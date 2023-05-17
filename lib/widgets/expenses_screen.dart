import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';
import 'package:flutter_expense_tracker_app/widgets/chart/chart_section.dart';
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
        title: "Project Meeting",
        amount: 599.0,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Watching Youtube",
        amount: 200.0,
        date: DateTime.now(),
        category: Category.lesiure),
    Expense(
        title: "Pizza",
        amount: 350.0,
        date: DateTime.now(),
        category: Category.food),
  ];

  void _addExpenseInList(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenseFromList(Expense expense) {
    var expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Removed"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseModalOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return ExpenseModal(onAddExpense: _addExpenseInList);
        });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Widget mainWidget = const Center(
      child: Text(
        "No Expense found. Start adding some!!",
        textAlign: TextAlign.center,
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainWidget = ExpenseList(
          expenseList: _registeredExpenses,
          onItemSwipe: _removeExpenseFromList);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseModalOverlay,
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
        ],
      ),
      body: (width < 600)
          ? Column(
              children: [
                Column(children: [
                  const SizedBox(height: 20),
                  Text(
                    "Expense Chart by Category",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  ChartSection(expenseList: _registeredExpenses),
                ]),
                mainWidget,
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Expense Chart by Category",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      ChartSection(expenseList: _registeredExpenses),
                    ],
                  ),
                ),
                mainWidget,
              ],
            ),
    );
  }
}
