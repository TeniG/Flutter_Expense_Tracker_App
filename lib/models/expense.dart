import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {food, travel, lesiure, work,}

class Expense {
  
   Expense({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category
    }) :  id = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'


  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
