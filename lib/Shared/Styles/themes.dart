import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';
import 'fonts.dart';
import 'styles.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: font!,
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.grey.shade100,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.grey.shade100,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey.shade100,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: font!),
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey.shade100,
    selectedIconTheme: const IconThemeData(size: 28.0, color: defaultColor),
    unselectedIconTheme: const IconThemeData(size: 24.0),
    selectedLabelStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: defaultColor),
    unselectedLabelStyle: const TextStyle(fontSize: 12.0),
    unselectedItemColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: TextTheme(
    headline1: lightHeadline1,
    headline2: lightHeadline2,
    headline3: lightHeadline3,
    headline4: lightHeadline4,
    headline5: lightHeadline5,
    headline6: lightHeadline6,
    bodyText1: lightBodyText1,
    bodyText2: lightBodyText2,
    subtitle1: lightSubtitle1,
    subtitle2: lightSubtitle2,
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.black87,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(width: 0.5, color: Colors.black87),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(width: 0.5, color: defaultColor),
    ),
    alignLabelWithHint: true,
    labelStyle: const TextStyle(color: Colors.black87),
    iconColor: defaultColor,
    focusColor: defaultColor,
    hoverColor: defaultColor,
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: font!,
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: HexColor('333739'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(fontSize: 24.0, color: Colors.grey.shade300, fontWeight: FontWeight.bold, fontFamily: font!),
    iconTheme: IconThemeData(color: Colors.grey.shade300),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    selectedIconTheme: const IconThemeData(size: 28.0, color: defaultColor),
    unselectedIconTheme: const IconThemeData(size: 24.0),
    selectedLabelStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: defaultColor),
    unselectedLabelStyle: const TextStyle(fontSize: 12.0),
    unselectedItemColor: Colors.grey.shade300,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
  ),
  iconTheme: IconThemeData(color: Colors.grey.shade300),
  textTheme: TextTheme(
    headline1: darkHeadline1,
    headline2: darkHeadline2,
    headline3: darkHeadline3,
    headline4: darkHeadline4,
    headline5: darkHeadline5,
    headline6: darkHeadline6,
    bodyText1: darkBodyText1,
    bodyText2: darkBodyText2,
    subtitle1: darkSubtitle1,
    subtitle2: darkSubtitle2,
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.grey.shade300,
    labelStyle: TextStyle(color: Colors.grey.shade300),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(width: 0.5, color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(width: 0.5, color: defaultColor),
    ),
    alignLabelWithHint: true,
    hintStyle: const TextStyle(color: defaultColor),
    iconColor: defaultColor,
    focusColor: defaultColor,
    hoverColor: defaultColor,
  ),
);
