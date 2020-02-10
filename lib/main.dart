import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_own_flashcard/db/database.dart';

import 'screens/home_screen.dart';

MyDatabase database;

void main() {
  database = MyDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "私だけの単語帳",
      theme: ThemeData(fontFamily: "Lanobe", brightness: Brightness.dark),
      home: HomeScreen(),
    );
  }
}
