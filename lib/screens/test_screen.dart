import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  final bool isIncludeWord;


  TestScreen({this.isIncludeWord});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
