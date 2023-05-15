import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';
import 'package:flutter_expense_tracker_app/widgets/chart/chat_bar.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({super.key, required this.expenseList});

  final List<Expense> expenseList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ChatBar(),
        const SizedBox(height: 6,),
        Row(
          children: Category.values
              .map((category) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(categoryIcons[category]),
                ),
              ))
              .toList(),
        )
      ],
    );
  }
}
