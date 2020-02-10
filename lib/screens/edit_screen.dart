import 'package:flutter/material.dart';
import 'package:moor_ffi/database.dart';
import 'package:my_own_flashcard/db/database.dart';
import 'package:my_own_flashcard/main.dart';
import 'package:my_own_flashcard/screens/word_list_screen.dart';
import 'package:toast/toast.dart';

enum EditStatus { ADD, EDIT }

class EditScreen extends StatefulWidget {
  final EditStatus status;
  final Word word;

  EditScreen({@required this.status, this.word});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  String _titleText = "";

  bool _isQuestionEnabled;

  @override
  void initState() {
    super.initState();

    if (widget.status == EditStatus.ADD) {
      _titleText = "新しい単語の追加";
      questionController.text = "";
      answerController.text = "";
      _isQuestionEnabled = true;
    } else {
      _titleText = "登録した単語の編集";
      questionController.text = widget.word.strQuestion;
      answerController.text = widget.word.strAnswer;
      _isQuestionEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backToWordListScreen(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(_titleText),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.done),
                tooltip: "登録",
                onPressed: () => onWordRegistered(),
              )
            ],
          ),
          //キーボードが出た時の画面で画面が自動スクロールするようになる。
          body: SingleChildScrollView(
            child: Column(
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
                //問題入力部分
                _questionInputPart(),
                SizedBox(
                  height: 50.0,
                ),
                //答え入力部分
                _answerInputPart()
              ],
            ),
          )),
    );
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
            enabled: _isQuestionEnabled,
            controller: questionController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }

  Widget _answerInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            "こたえ",
            style: TextStyle(fontSize: 24.0),
          ),
          TextField(
            controller: answerController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }

  Future<bool> _backToWordListScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WordListScreen()));
    return Future.value(false);
  }

  onWordRegistered() {
    if (widget.status == EditStatus.ADD) {
      _insetWord();
    } else {
      _updateWord();
    }
  }

  _insetWord() async {
    if (questionController.text == "" || answerController.text == "") {
      Toast.show("問題と答えの両方を入力しないと登録できません。", context,
          duration: Toast.LENGTH_LONG);
      return;
    }
    var word = Word(
        strQuestion: questionController.text, strAnswer: answerController.text);

    try {
      await database.addWord(word);
      questionController.clear();
      answerController.clear();
      Toast.show("登録が完了しました。", context, duration: Toast.LENGTH_LONG);
    } on SqliteException catch (e) {
      Toast.show("この問題はすに登録されているので登録できません。", context,
          duration: Toast.LENGTH_LONG);
    }
  }

  void _updateWord() async {
    if (questionController.text == "" || answerController.text == "") {
      Toast.show("問題と答えの両方を入力しないと登録できません。", context,
          duration: Toast.LENGTH_LONG);
      return;
    }
    var word = Word(
        strQuestion: questionController.text,
        strAnswer: answerController.text,
        isMemorized: false);

    try {
      await database.updateWord(word);
      _backToWordListScreen();
      Toast.show("修正が完了しました。", context, duration: Toast.LENGTH_LONG);
    } on SqliteException catch (e) {
      Toast.show("何らかの問題が発生して登録できませんでした。:$e", context,
          duration: Toast.LENGTH_LONG);
      return;
    }
  }
}
