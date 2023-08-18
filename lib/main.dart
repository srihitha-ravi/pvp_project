import 'package:flutter/material.dart';
import 'package:pvp_project/screens/attractiveness_calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attractiveness Calculator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: AttractivenessCalculator(),
    );
  }
}
