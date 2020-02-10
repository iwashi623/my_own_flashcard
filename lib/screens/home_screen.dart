import 'package:flutter/material.dart';
import 'package:my_own_flashcard/parts/button_with_icon.dart';
import 'package:my_own_flashcard/screens/word_list_screen.dart';

import 'test_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isIncludeWord = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset("assets/images/image_title.png")),
            _titleText(),
            //横線
            Divider(
              height: 50.0,
              color: Colors.white,
              indent: 8.0,
              endIndent: 8.0,
            ),
            //確認ボタン(ButtonWithIconクラスとして処理を外だししている)
            ButtonWithIcon(
              onPressed: () => _startTestScreen(context),
              icon: Icon(Icons.play_arrow),
              label: "かくにんテストをする",
              color: Colors.brown,
            ),
            SizedBox(
              height: 10.0,
            ),
            //ラジオボタン
            _radioButtons(),
            SizedBox(
              height: 10.0,
            ),
            //単語帳一覧ボタン(ButtonWithIconクラスとして処理を外だししている)
            ButtonWithIcon(
              onPressed: () => _startWordListScreen(context),
              icon: Icon(Icons.list),
              label: "単語一覧を見る",
              color: Colors.redAccent,
            ),
            SizedBox(
              height: 60.0,
            ),
            Text(
              "powered by K-Iwashita 2020",
              style: TextStyle(fontFamily: "Mont"),
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleText() {
    return Column(
      children: <Widget>[
        Text(
          "私だけの単語帳",
          style: TextStyle(fontSize: 40.0),
        ),
        Text("My Own Frashcard",
            style: TextStyle(fontSize: 24.0, fontFamily: "Mont"))
      ],
    );
  }

  Widget _radioButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: Column(
        children: <Widget>[
          RadioListTile(
            title: Text(
              "暗記済みの単語を除外する",
              style: TextStyle(fontSize: 16.0),
            ),
            value: false,
            groupValue: isIncludeWord,
            onChanged: (value) => _onRadioSelected(value),
          ),
          RadioListTile(
            title: Text(
              "暗記済みの単語を含む",
              style: TextStyle(fontSize: 16.0),
            ),
            value: true,
            groupValue: isIncludeWord,
            onChanged: (value) => _onRadioSelected(value),
          )
        ],
      ),
    );
  }

  _onRadioSelected(value) {
    setState(() {
      isIncludeWord = value;
    });
  }

  _startWordListScreen(BuildContext context) {
    Navigator.push(
        context,
        //次のページのクラス名を処理の内容として明示する。(WordListScreen)
        MaterialPageRoute(builder: (context) => WordListScreen()));
  }

  _startTestScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TestScreen(
                  isIncludeWord: isIncludeWord,
                )));
  }
}
