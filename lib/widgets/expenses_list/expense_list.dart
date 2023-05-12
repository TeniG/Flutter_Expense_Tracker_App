import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';
import 'package:flutter_expense_tracker_app/widgets/expenses_list/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({required this.expenseList, required this.onItemSwipe, super.key});

  final List<Expense> expenseList;
  final void Function(Expense) onItemSwipe;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (context, index) {
            return Dismissible(
                key: ValueKey(expenseList[index]),
                onDismissed: (direction) {
                  onItemSwipe(expenseList[index]);
                },
                child: ExpenseItem(expense: expenseList[index]));
          }),
    );
  }
}
