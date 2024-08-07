import 'package:expense_tracker_app/components/expense.dart';
import 'package:expense_tracker_app/main.dart';
import 'package:expense_tracker_app/models/chart.dart';
import 'package:expense_tracker_app/models/expense_list.dart';
import 'package:expense_tracker_app/models/total_expense.dart';
import 'package:expense_tracker_app/screen/expense_adding_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _totalExpense = 0.0;
  final List<Expense> _expenseList = [];

  void _updateTotalExpense() {
    setState(() {
      _totalExpense = _expenseList.fold(0.0, (sum, item) => sum + item.amount);
    });
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      _expenseList.add(newExpense);
      _updateTotalExpense();
    });
  }

  void _removeExpense(Expense expense) {
    int? index;

    setState(() {
      index = _expenseList.indexOf(expense);
      _expenseList.removeWhere((e) => e.id == expense.id);
      _updateTotalExpense();
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: kShadowColor,
        content: Text('Expense is Deleted', style: TextStyle(color: kTextColor2, fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.left,),
        action: SnackBarAction(
          label: 'Undo',
          textColor: kTextColor3,
          onPressed: () {
            setState(() {
              _expenseList.insert(index!, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverLay() {
    showModalBottomSheet(
      context: context, 
      builder: (ctx) => ExpenseAddingScreen(onSubmit: _addExpense,)
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContext = Expanded(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('No expenses found.', style: TextStyle(color: kShadowColor, fontSize: 25,), textAlign: TextAlign.center,),
            Text('Start adding some!!!', style: TextStyle(color: kShadowColor, fontSize: 25,), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );

    if(_expenseList.isNotEmpty) {
      mainContext = ExpenseList(expenses: _expenseList, removeExpense: _removeExpense,);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBgColor2,
        title: Text(
          'Flutter Expense Tracker',
          style: TextStyle(
            color: kTextColor2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverLay, 
            icon: const Icon(Icons.add),
            color: kTextColor2,
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _expenseList),
          Expanded(child: mainContext),
          TotalExpense(totalExpense: _totalExpense),
        ],
      ),
    );
  }
}
