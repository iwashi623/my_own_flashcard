import 'package:flutter/material.dart';

import 'edit_screen.dart';


class WordListScreen extends StatefulWidget {
  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("単語一覧"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewWord(),
        child: Icon(Icons.add),
        tooltip: "新しい単語の登録",
      ),
    );
  }

  _addNewWord() {
    //ただのpushで遷移すると前画面の状態が変化しないので、戻ったときに新たに追加した単語が反映されていない。
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => EditScreen()
    ));
  }
}
