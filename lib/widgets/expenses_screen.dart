import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';
import 'package:flutter_expense_tracker_app/widgets/expense_modal.dart';
import 'package:flutter_expense_tracker_app/widgets/expenses_list/expense_list.dart';

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

  void _openAddExpenseModalOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return const ExpenseModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseModalOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(children: [
        const Text("Chart"),
        ExpenseList(expenses: _registeredExpenses)
      ]),
    );
  }
}
