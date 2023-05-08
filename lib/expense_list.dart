import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({required this.expenses, super.key});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            return Text(expenses[index].title);
          }),
    );
  }
}
