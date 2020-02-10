import 'package:flutter/material.dart';

enum TestStatus { BEFORE_START, SHOW_QUESTION, SHOW_ANSWER, FINISHED }

class TestScreen extends StatefulWidget {
  final bool isIncludeWord;

  TestScreen({this.isIncludeWord});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _numberOfQuestion = 0;
  String _textQuestion = "テスト";
  String _textAnswer = "こたえ";

  bool _isMemorized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("かくにんテスト"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print("おしました"),
          child: Icon(Icons.skip_next),
          tooltip: "次に進む",
        ),
        body: Column(
          children: <Widget>[
            _numberOfQuestionsPart(),
            SizedBox(
              height: 20.0,
            ),
            _questionCardPart(),
            SizedBox(
              height: 20.0,
            ),
            _answerCardPars(),
            SizedBox(
              height: 40.0,
            ),
            _isMemorizedCheckPart()
          ],
        ));
  }

  Widget _numberOfQuestionsPart() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "のこり問題数",
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            _numberOfQuestion.toString(),
            style: TextStyle(fontSize: 24.0),
          )
        ],
      ),
    );
  }

  Widget _questionCardPart() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset("assets/images/image_flash_question.png"),
        Text(
          _textQuestion,
          style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
        )
      ],
    );
  }

  Widget _answerCardPars() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset("assets/images/image_flash_answer.png"),
        Text(_textAnswer, style: TextStyle(fontSize: 20.0))
      ],
    );
  }

  Widget _isMemorizedCheckPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: CheckboxListTile(
          title: Text(
            "暗記済みにする場合はチェックを入れてください。",
            style: TextStyle(fontSize: 14.0),
          ),
          value: _isMemorized,
          onChanged: (value) {
            setState(() {
              _isMemorized = value;
            });
          }),
    );
  }
}
