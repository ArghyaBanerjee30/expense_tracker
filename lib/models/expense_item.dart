import 'package:expense_tracker_app/components/expense.dart';
import 'package:expense_tracker_app/main.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kBgColor1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: TextStyle(
                color: kTextColor1,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('₹${expense.amount.toStringAsFixed(2)}', style: TextStyle(color: kTextColor1,),),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expense.category],
                      color: kIconColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(expense.getFormattedDate, style: TextStyle(color: kTextColor1,),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
