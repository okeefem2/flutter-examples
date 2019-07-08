import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _score;
  final Function _reset;

  String get resultPhrase {
    var resultText = 'You did it!';
    if (_score <= 6) {
      resultText = 'You welcome the bleakness of life';
    } else if (_score <= 12) {
      resultText = 'The black void of your heart is like that of satan himself';
    }
    return resultText;
  }

  Result(this._score, this._reset);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Your score: $_score',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        Text(
          resultPhrase,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        FlatButton(
          child: Text('Reset',
              style: TextStyle(
                fontSize: 24,
                color: Colors.teal,
              )),
          onPressed: _reset,
        )
      ],
    ));
  }
}
