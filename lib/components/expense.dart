import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food,
  transport,
  entertainment,
  utilities,
  health,
  other,
}

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.transport: Icons.directions_car,
  Category.entertainment: Icons.movie,
  Category.utilities: Icons.lightbulb,
  Category.health: Icons.health_and_safety,
  Category.other: Icons.category,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime? dateTime;
  final Category category;

  Expense({required this.title, required this.amount, required this.dateTime, required this.category}) : id = uuid.v4();

  String get getFormattedDate {
    return '${dateTime!.month}/${dateTime!.day}/${dateTime!.year}';
  }

  Expense copyWith({
    String? title,
    double? amount,
    DateTime? dateTime,
    Category? category,
  }) {
    return Expense(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
      category: category ?? this.category,
    );
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenseList;

  const ExpenseBucket({required this.category, required this.expenseList});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
  : expenseList = allExpenses.where((element) => (element.category == category)).toList();

  double totalExpenses() {
    double sum = 0;
    for(final expense in expenseList) {
      sum += expense.amount;
    }
    return sum;
  }
}