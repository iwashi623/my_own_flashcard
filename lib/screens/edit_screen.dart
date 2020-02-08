import 'package:flutter/material.dart';
import 'package:my_own_flashcard/screens/word_list_screen.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backToWordListScreen(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("新しい単語の登録"),
            centerTitle: true,
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
}
