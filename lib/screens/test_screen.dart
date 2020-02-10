import 'package:flutter/material.dart';
import 'package:my_own_flashcard/db/database.dart';
import 'package:my_own_flashcard/main.dart';

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
  List<Word> _testDataList = List();
  TestStatus _testStatus;
  bool _isQuestionCardVisible = false;
  bool _isAnswerCardVisible = false;
  bool _isCheckBoxVisible = false;
  bool _isFabVisible = false;
  int _index = 0;
  Word _currentWord;

  @override
  void initState() {
    super.initState();
    _getTestData();
  }

  void _getTestData() async {
    if (widget.isIncludeWord) {
      _testDataList = await database.allWord;
    } else {
      _testDataList = await database.allWordsExcludedMemorized;
    }

    _testDataList.shuffle();
    _testStatus = TestStatus.BEFORE_START;
    _index = 0;

    setState(() {
      _isQuestionCardVisible = false;
      _isAnswerCardVisible = false;
      _isCheckBoxVisible = false;
      _isFabVisible = true;
      _numberOfQuestion = _testDataList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("かくにんテスト"),
          centerTitle: true,
        ),
        floatingActionButton: _isFabVisible
            ? FloatingActionButton(
                onPressed: () => _goNextStatus(),
                child: Icon(Icons.skip_next),
                tooltip: "次に進む",
              )
            : null,
        body: Stack(
          children: <Widget>[
            Column(
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
            ),
            _endMessage()
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
    if (_isQuestionCardVisible) {
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
    } else {
      return Container();
    }
  }

  Widget _answerCardPars() {
    if (_isAnswerCardVisible) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset("assets/images/image_flash_answer.png"),
          Text(_textAnswer, style: TextStyle(fontSize: 20.0))
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _isMemorizedCheckPart() {
    if (_isCheckBoxVisible) {
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
    } else {
      return Container();
    }
  }

  _goNextStatus() async {
    switch (_testStatus) {
      case TestStatus.BEFORE_START:
        _testStatus = TestStatus.SHOW_QUESTION;
        _showQuestion();
        break;
      case TestStatus.SHOW_QUESTION:
        _testStatus = TestStatus.SHOW_ANSWER;
        _showAnswer();
        break;
      case TestStatus.SHOW_ANSWER:
        await _updateMemorizedFlag();
        if (_numberOfQuestion == 0) {
          setState(() {
            _isFabVisible = false;
            _testStatus = TestStatus.FINISHED;
          });
        } else {
          _testStatus = TestStatus.SHOW_QUESTION;
          _showQuestion();
        }
        break;
      case TestStatus.FINISHED:
        break;
    }
  }

  void _showQuestion() {
    _currentWord = _testDataList[_index];
    setState(() {
      _isQuestionCardVisible = true;
      _isAnswerCardVisible = false;
      _isCheckBoxVisible = false;
      _isFabVisible = true;
      _textQuestion = _currentWord.strQuestion;
    });
    _numberOfQuestion -= 1;
    _index += 1;
  }

  void _showAnswer() {
    setState(() {
      _isQuestionCardVisible = true;
      _isAnswerCardVisible = true;
      _isCheckBoxVisible = true;
      _isFabVisible = true;
      _textAnswer = _currentWord.strAnswer;
      _isMemorized = _currentWord.isMemorized;
    });
  }

  Future<void> _updateMemorizedFlag() async {
    var updateWord = Word(
        strQuestion: _currentWord.strQuestion,
        strAnswer: _currentWord.strAnswer,
        isMemorized: _isMemorized);

    await database.updateWord(updateWord);
  }

  Widget _endMessage() {
    if (_testStatus == TestStatus.FINISHED) {
      return Center(
          child: Text(
        "テスト終了",
        style: TextStyle(fontSize: 50.0),
      ));
    } else {
      return Container();
    }
  }
}
