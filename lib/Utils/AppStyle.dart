import 'package:flutter/material.dart';

const PrimaryColor = Color.fromARGB(255, 48, 3, 85);
const LightGrey = Color(0xFFF2F2F2);
const FormBackGraund = Color(0xFFF1F5F9);
const TextGrey = Color(0xFF424A5D);
const BorderGrey = Color(0xFFBFBFBF);
const BGColor = Color(0xFF253685);

const DarkPrimaryColor = Color(0xFF1A73E8);
const DarkBGColor = Color(0xFF003564);
const DarkTextColor = Color(0xFFE0E0E0);
const DarkBorderColor = Color(0xFF424242);


const TextStyle titleCardStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
const TextStyle textStyle = TextStyle(
  fontSize: 16,
  color: TextGrey,
);
const TextStyle FormTextStyle = TextStyle(
  fontSize: 15,
  color: BorderGrey,
  fontWeight: FontWeight.w400,
);
const TextStyle AppBarTextStyle = TextStyle(
  fontSize: 22,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: PrimaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: TextGrey),
    titleTextStyle: AppBarTextStyle,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: DarkPrimaryColor,
  scaffoldBackgroundColor: DarkBGColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkBGColor,
    iconTheme: IconThemeData(color: DarkTextColor),
    titleTextStyle: TextStyle(fontSize: 22, color: DarkTextColor, fontWeight: FontWeight.w500),
  ),
);

