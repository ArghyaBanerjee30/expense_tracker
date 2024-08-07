import 'package:expense_tracker_app/main.dart';
import 'package:flutter/material.dart';

class TotalExpense extends StatelessWidget {
  final double totalExpense;

  const TotalExpense({super.key, required this.totalExpense});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgColor2,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Text(
            'Total Expense:',
            style: TextStyle(
                color: kBgColor1, fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          const Spacer(),
          Text(
            '₹$totalExpense',
            style: TextStyle(
                color: kBgColor1, fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
