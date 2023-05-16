import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';
import 'package:flutter_expense_tracker_app/widgets/chart/chat_bar.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({super.key, required this.expenseList});

  final List<Expense> expenseList;

  List<ExpenseBucket> get bucketList {
    final List<ExpenseBucket> bucketList = [];
    for (Category category in Category.values) {
      bucketList.add(ExpenseBucket.forCategory(expenseList, category));
    }
    return bucketList;
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (ExpenseBucket expensebucket in bucketList) {
      if (maxTotalExpense < expensebucket.totalExpense) {
        maxTotalExpense = expensebucket.totalExpense;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (ExpenseBucket bucket in bucketList)
                  ChatBar(
                      chartBarPercentage: (bucket.totalExpense == 0)
                          ? 0
                          : bucket.totalExpense / maxTotalExpense)
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: Category.values
                .map((category) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          categoryIcons[category],
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
