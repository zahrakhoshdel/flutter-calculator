import 'package:flutter/material.dart';
import 'package:my_calculator/body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //static const String title = ;

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Body(),
    );
  }
}
