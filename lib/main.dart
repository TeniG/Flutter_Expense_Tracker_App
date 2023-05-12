import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/widgets/expenses_screen.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.onPrimary),
          cardTheme: const CardTheme().copyWith(
              margin: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
          )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.onPrimary,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  
                  fontWeight: FontWeight.normal,
                  color: kColorScheme.onSecondaryContainer
                ),
              )),
      home: const Expenses(),
    ),
  );
}
