import 'package:flutter/material.dart';
import 'package:review_app_project/screens/review.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Review(),
    );
  }
}
