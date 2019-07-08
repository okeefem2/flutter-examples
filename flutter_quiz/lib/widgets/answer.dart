import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String _answer;
  final Function _answerHandler;
  Answer(this._answer, this._answerHandler);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.tealAccent,
        child: Text(_answer),
        onPressed: _answerHandler,
      ),
    );
  }
}
