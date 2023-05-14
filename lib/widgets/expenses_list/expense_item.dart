import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/main.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({required this.expense, super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: kColorScheme.onPrimaryContainer)),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  "\$${expense.amount.toStringAsFixed(2)}",
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDateTime),
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
