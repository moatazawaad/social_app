import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getThemeDataLight() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      appBarTheme: const AppBarTheme(
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        elevation: 5.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          // statusBarColor: Colors.green,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          color: Colors.deepPurple,
          fontFamily: 'Jannah',
        ),
        iconTheme: IconThemeData(
          color: Colors.deepPurple,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
      )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        elevation: 10.0,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          height: 1.2,
        ),
      ),
      fontFamily: 'Jannah',
    );
