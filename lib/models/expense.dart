import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  lesiure,
  work,
  learning,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.lesiure: Icons.movie_creation_outlined,
  Category.work: Icons.work,
  Category.learning: Icons.edit_document
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDateTime {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.exspenseList});

  ExpenseBucket.forCategory( List<Expense> allExpense, this.category)
      : exspenseList = allExpense
            .where((element) => element.category == category)
            .toList();

  final Category category;
  final List<Expense> exspenseList;

  double get totalExpense {
    double sum = 0;
    for (var expense in exspenseList) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
