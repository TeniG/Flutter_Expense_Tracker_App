import 'package:flutter/material.dart';

class ChatBar extends StatelessWidget {
  const ChatBar({super.key, required this.chartBarPercentage});

  final double chartBarPercentage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: chartBarPercentage,
          child:  DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8)
              ),
            ),
          ),
        ),
      );
    
  }
}
