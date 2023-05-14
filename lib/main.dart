import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/widgets/expenses_screen.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125));
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData().copyWith(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
         appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kDarkColorScheme.onPrimaryContainer,
              foregroundColor: kDarkColorScheme.onPrimary),
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: kDarkColorScheme.primaryContainer,
              backgroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          )
      ),
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
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kColorScheme.onSecondaryContainer),
              )),
      home: const Expenses(),
      themeMode: ThemeMode.system,
    ),
  );
}
