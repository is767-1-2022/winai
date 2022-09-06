import 'package:flutter/material.dart';

import 'pages/fifth_page.dart';
import 'pages/first_page.dart';
import 'pages/fourth_page.dart';
import 'pages/home_page.dart';
import 'pages/second_page.dart';
import 'pages/third_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/1',
      routes: {
        '/home': (context) => const MyHomePage(title: 'Home'),
        '/1': (context) => FirstPage(),
        '/2': (context) => SecondPage(),
        '/3': (context) => ThirdPage(),
        '/4': (context) => FourthPage(),
        '/5': (context) => FifthPage(),
      },
    );
  }
}
