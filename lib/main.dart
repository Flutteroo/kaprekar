// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:kaprekar/constants.dart';
import 'package:kaprekar/screens/input_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en';
  initializeDateFormatting('en', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        primarySwatch: primarySwatch,
        primaryColor: accentColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        disabledColor: primarySwatch,
        shadowColor: colorRed,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatch,
          accentColor: accentColor,
          cardColor: themeColor,
          backgroundColor: themeColor,
          errorColor: colorRed,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: style,
          hintStyle: style,
          fillColor: themeColor,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: themeColor, width: 2),
          ),
        ),
        textTheme: const TextTheme(
            headlineSmall: style,
            headlineMedium: style,
            titleMedium: style,
            bodyMedium: style,
            bodySmall: style),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey[300],
              textStyle: style.copyWith(height: 1.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              )),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: accentColor,
              textStyle: style,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: themeColor,
            titleTextStyle: style.copyWith(fontSize: 32, color: primarySwatch)),
        dialogTheme: DialogThemeData(
          actionsPadding: const EdgeInsets.all(8),
          backgroundColor: Colors.black87,
          titleTextStyle: style.copyWith(fontSize: 24),
          contentTextStyle: style.copyWith(fontSize: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(color: colorGrey),
            selectedItemColor: primarySwatch,
            unselectedItemColor: accentColor,
            type: BottomNavigationBarType.shifting),
      ),
      home: const InputScreen(),
    );
  }
}
