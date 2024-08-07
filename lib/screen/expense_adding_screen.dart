import 'package:expense_tracker_app/components/expense.dart';
import 'package:expense_tracker_app/main.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/components/expense.dart' as expense;

class ExpenseAddingScreen extends StatefulWidget {
  final void Function(Expense) onSubmit;
  const ExpenseAddingScreen({super.key, required this.onSubmit});

  @override
  State<ExpenseAddingScreen> createState() => _ExpenseAddingScreenState();
}

class _ExpenseAddingScreenState extends State<ExpenseAddingScreen> {
  Expense _expenseDetails = Expense(
    title: '',
    amount: 0.0,
    dateTime: null,
    category: Category.food,
  );
  expense.Category? _selectedCategory;

  @override
  void initState() {
    _selectedCategory = _expenseDetails.category;
    super.initState();
  }

  void _saveTitle(String inputTitle) {
    setState(() {
      _expenseDetails = _expenseDetails.copyWith(title: inputTitle);
    });
  }

  void _saveAmount(String inputAmount) {
    setState(() {
      _expenseDetails = _expenseDetails.copyWith(amount: double.tryParse(inputAmount) ?? 0.0);
    });
  }

  void _fetchDate() async{
    final DateTime today = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today, 
      firstDate: DateTime(today.year - 1, today.month, today.day), 
      lastDate: today
    );
    
    setState(() {
      _expenseDetails = _expenseDetails.copyWith(dateTime: pickedDate);
    });
  }

  void _saveCategory(expense.Category? inputCategory) {
    setState(() {
      _selectedCategory = inputCategory!;
      _expenseDetails = _expenseDetails.copyWith(category: inputCategory);
    });
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  bool _isFormValid() {
    return (_expenseDetails.title.isNotEmpty && _expenseDetails.amount > 0.0 && _expenseDetails.dateTime != null);
  }

  void _submit() {
    if(_isFormValid()) {
      setState(() {
        widget.onSubmit(_expenseDetails);
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(     
        children: [
          TextField(
            onChanged: _saveTitle,
            maxLength: 50,
            style: TextStyle(color: kTextColor1,),
            decoration: InputDecoration(
              label: Text('Title', style: TextStyle(color: kTextColor1, fontSize: 15, fontWeight: FontWeight.w500),)
            ),
          ),

          const SizedBox(height: 5,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => _saveAmount(value),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: kTextColor1,),
                  decoration: InputDecoration(
                    label: Text('Amount', style: TextStyle(color: kTextColor1, fontSize: 15, fontWeight: FontWeight.w500),),
                    prefixText: '₹ ',
                    prefixStyle: TextStyle(color: kTextColor1),
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: TextButton(
                  onPressed: _fetchDate,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _expenseDetails.dateTime != null
                        ? _expenseDetails.getFormattedDate
                        : 'No date selected',
                        style: TextStyle(color: _expenseDetails.dateTime != null ? kTextColor1 : kShadowColor, fontSize: 15,)
                      ),
                      const SizedBox(width: 10,),
                      Icon(Icons.calendar_month, color: kTextColor1, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30,),

          Row( 
            children: [
              DropdownButton<expense.Category>(
                style: TextStyle(color: kTextColor1, fontSize: 12, fontWeight: FontWeight.bold),
                value: _selectedCategory,
                items: expense.Category.values.map((expense.Category category) {
                  return DropdownMenuItem<expense.Category>(
                    value: category,
                    child: Text(category.toString().split('.').last.toUpperCase()),
                  );
                }).toList(), 
                onChanged: _saveCategory,
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: _cancel, 
                    child: Text('Cancel', style: TextStyle(color: kTextColor1, fontSize: 14, fontWeight: FontWeight.bold),)
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid() ? kBgColor1 : kDisableButton,
                    ), 
                    child: Text('Save Expense', style: TextStyle(color: _isFormValid() ? kTextColor1 : kShadowColor, fontSize: 14, fontWeight: FontWeight.bold),),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}