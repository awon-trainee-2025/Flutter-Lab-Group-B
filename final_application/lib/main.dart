import 'package:flutter/material.dart';
import 'package:final_application/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe App',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: HomePage(),
    );
  }
}
