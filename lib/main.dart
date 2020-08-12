import 'package:flutter/material.dart';
import 'package:quiz_app/question.dart';
import 'package:quiz_app/result.dart';

import 'answers.dart';
void main(){
   runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex=0;
  var _totalScore=0;
  final _questions=const [
    {'questionText':'What\'s your favourite color?',
      'answers':[
        {'text':'Black','score':10},
        {'text':'Red','score':5},
        {'text':'Green','score':3},
        {'text':'White','score':1}],
    },//map in list
    {'questionText':'What\'s your favourite animal?',
      'answers':[
          {'text':'Rabbit','score':3},
          {'text':'Snake','score':11},
           {'text':'Elephant','score':5},
          {'text':'Lion','score':9}
      ],
    },
    {'questionText':'Who\'s your favourite instructor?',
      'answers':[
    {'text':'Max','score':1},
    {'text':'Max','score':1},
    {'text':'Max','score':1},
    {'text':'Max','score':1},
      ],
    },
  ];

  void _answerQuestion(int score){
    _totalScore=_totalScore+score;
    setState(() {
      _questionIndex=_questionIndex+1;
    });
  }

  void _resetQuiz(){
    setState(() {
      _questionIndex=0;
      _totalScore=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body:(_questionIndex<_questions.length)?Column(
          children: <Widget>[
            Question(_questions[_questionIndex]['questionText']),
            // ... is spread operators used because it allows list in column
            // here map used to return no of answer option according to question
            ...(_questions[_questionIndex]['answers'] as List<Map<String,Object>>) .map((answer){
              return Answer(selectHandler: ()=> _answerQuestion(answer['score']),answerText: answer['text'],);
            }).toList(),
          ],
        ):Result(resultScore: _totalScore,resetHandler: _resetQuiz,),
      ),
    );
  }
}