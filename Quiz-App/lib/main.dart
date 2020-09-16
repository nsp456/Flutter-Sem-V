import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizBrain.dart';

QuizBrain qb = QuizBrain();
void main() {
  runApp(Quiz());
}

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                "Flutter Quiz",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              )),
              backgroundColor: Colors.blue,
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: OopsConcept(),
              ),
            ),
          ),
        ));
  }
}

int currentScore = 0;

class OopsConcept extends StatefulWidget {
  @override
  _OopsConceptState createState() => _OopsConceptState();
}

class _OopsConceptState extends State<OopsConcept> {
  List<Widget> score = [];
  List<bool> ans = [true, false, true];

  void check(bool yourAnswer) {
    bool correctAns = qb.getAnswer();
    setState(() {
      if (qb.isFinished() == true) {
        if (yourAnswer == correctAns) {
          currentScore++;
          score.add(Icon(
            Icons.check,
            color: Colors.lightGreen,
          ));
        }
        Alert(
          context: context,
          title: "You Scored: ${currentScore * 10} / 30",
          desc: 'You\'ve reached the end of the quiz.',
          image: Image.asset("assets/images/completed.jpg"),
          // buttons: [
          //   DialogButton(
          //     child: Text(
          //       "Take Quiz Again",
          //       style: TextStyle(color: Colors.white, fontSize: 20),
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         qb.reset();
          //         score = [];
          //       });
          //     },
          //     color: Color.fromRGBO(120, 111, 10, 5.0),
          //     radius: BorderRadius.circular(20.0),
          //   ),
          // ],
        ).show();
        qb.reset();
        currentScore = 0;
        score = [];
      } else {
        if (yourAnswer == correctAns) {
          currentScore++;
          score.add(Icon(
            Icons.check,
            color: Colors.lightGreen,
          ));
        } else {
          score.add(
            Icon(
              Icons.close,
              color: Colors.redAccent,
            ),
          );
        }
        qb.nextquestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qb.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.green,
              child: Text(
                "True",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              onPressed: () {
                check(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.red,
              child: Text(
                "False",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              onPressed: () {
                check(false);
              },
            ),
          ),
        ),
        Row(
          children: score,
        )
      ],
    );
  }
}
