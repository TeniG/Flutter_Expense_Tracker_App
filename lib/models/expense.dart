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
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.lesiure: Icons.movie_creation_outlined,
  Category.work: Icons.work,
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
