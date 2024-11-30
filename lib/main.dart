import 'package:flutter/material.dart';
import 'package:airvibe_weather_app/Activity/home.dart';
import 'package:airvibe_weather_app/Activity/loading.dart';

void main() {
  runApp(MaterialApp(
    title: 'AirVibe',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.blue, // Default primary color for AppBar, buttons, etc.
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionHandleColor: Colors.grey,
        selectionColor: Color.fromARGB(255, 233, 232, 232),

      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: CircleBorder(),

      ),
      appBarTheme: AppBarTheme(
        color: Colors.blue, // Set AppBar background color
        foregroundColor: Colors.white, // AppBar text/icon color
      ),
    ),
    routes: {
      "/" : (context) => Loading(),
      "/home" : (context) => Home(),
      "/loading" : (context) => Loading(),
    },
  ));
}

