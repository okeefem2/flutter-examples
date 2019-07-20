import 'package:flutter/material.dart';
import 'package:flutter_quiz/widgets/quiz.dart';
import 'package:flutter_quiz/widgets/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  // The reasoning for state being a separate class is so that it can be persisted
  // when the widget that owns the state is rebuilt
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//  Adding the _ to the class name makes it private by convention
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  // with keyword used for mixins
  // WidgetsBindingObserver is a mixin giving access to app lifecycle hooks
  //  Adding the _ to the property makes it private by convention
  int _questionIndex = 0;

  // var a = const []; this will allow reassign, but no modification
  // final means that it cannot change once it has been initialized
  // final b;
  // b = 'foo'; after this, the value is immutable

  var _totalScore = 0;

  // const on left side means you cannot reassign the variable
  static const _questions = const [
    // const on right side means you cannot modify the object
    {
      'question': 'Favorite color?',
      'answers': [
        {'answer': 'Black', 'score': 1},
        {'answer': 'Green', 'score': 2},
        {'answer': 'White', 'score': 3},
        {'answer': 'Red', 'score': 4},
      ],
    },
    {
      'question': 'Favorite animal?',
      'answers': [
        {'answer': 'Bat', 'score': 1},
        {'answer': 'Dog', 'score': 2},
        {'answer': 'Cat', 'score': 3},
        {'answer': 'Otter', 'score': 4},
      ],
    },
    {
      'question': 'Favorite book?',
      'answers': [
        {'answer': 'Slaughterhouse', 'score': 1},
        {'answer': '1984', 'score': 2},
        {'answer': 'Fear and Loathing', 'score': 3},
        {'answer': 'Full Dark No Stars', 'score': 4},
      ],
    },
  ];

  // From the WidgetsBindingObserver mixin
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Is fired whenever the app lifecycle is changed
    super.didChangeAppLifecycleState(state);
  }

  void initState() {
    // Register an observer to the didChangeAppLifecycleState
    // by passing this, since this implements didChangeAppLifecycleState it will observe it
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // Cleanup the observers to avoid memory leaks
    // Suspended may not be caught by the observer since we are clearing it out here
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _answerQuestion(int score) {
    // print('Answer Chosen $answer');
    setState(() {
      if (_questionIndex < _questions.length) {
        _questionIndex++;
        _totalScore += score;
      }
    });
  }

  void _reset() {
    // print('Answer Chosen $answer');
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      // Using a Center widget does the same thing for this case
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                answerHandler: _answerQuestion,
                questionIndex: _questionIndex)
            : Result(_totalScore, _reset),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
