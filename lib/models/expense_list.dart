import 'package:expense_tracker_app/components/expense.dart';
import 'package:expense_tracker_app/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  const ExpenseList({super.key, required this.removeExpense, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        itemCount: expenses.length,
        separatorBuilder: (ctx, index) => const SizedBox(height: 10),
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) => {
            removeExpense(expenses[index])
          }, 
          child: ExpenseItem(
            expense: expenses[index]
          ),
        ) ,
      ),
    );
  }
}
