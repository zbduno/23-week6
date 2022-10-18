import 'package:flutter/material.dart';

//import necessary packages
import 'show_dogs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Dogs List';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(primarySwatch: Colors.green),
      home: ShowDogsPage(),
    );
  }
}
