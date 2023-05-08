import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/expense_list.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 599.0,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Watching Youtube",
        amount: 19.0,
        date: DateTime.now(),
        category: Category.lesiure),
    Expense(
        title: "Pizza",
        amount: 100.0,
        date: DateTime.now(),
        category: Category.food),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text("Chart"),
        ExpenseList(expenses: _registeredExpenses)
      ]),
    );
  }
}
