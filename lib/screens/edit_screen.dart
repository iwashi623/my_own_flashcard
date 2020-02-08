import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("新しい単語の登録"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Text(
                "問題とこたえを入力して「登録」ボタンを押してください",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            //問題入力部分
            SizedBox(
              height: 30.0,
            ),
            _questionInputPart(),
          ],
        ));
  }

  Widget _questionInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            "問題",
            style: TextStyle(fontSize: 24.0),
          ),
          TextField(
            controller: questionController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }
}
