import 'package:flutter/material.dart';
import 'package:tiny_minds/pages/settings_page.dart';
import 'pages/first_page.dart';
import 'pages/learn_page.dart';
import 'pages/game_page.dart';
import 'pages/letters_page.dart';
import 'pages/numbers_page.dart';
import 'pages/animals_page.dart';
import 'pages/colors_page.dart';
import 'pages/shapes_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiny Minds',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/learn': (context) => LearnPage(),
        '/settings': (context) => SettingsPage(),
        '/game': (context) => GamePage(),
        '/letters': (context) => LettersPage('ABC'),
        '/numbers': (context) => NumbersPage('123'),
        '/animals': (context) => AnimalsPage('Animals'),
        '/colors': (context) => ColorsPage('Colors'),
        '/shapes': (context) => ShapesPage('Shapes'),
      },
    );
  }
}
