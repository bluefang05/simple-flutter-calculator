import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  var userQuestion = "";
  var userAnswer = "0";
  var willClear = false;
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = "";
                        willClear = false;
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.green[900],
                    textColor: Colors.white,
                  );
                } else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        if (userQuestion.length > 0) {
                          userQuestion = userQuestion.substring(
                              0, (userQuestion.length - 1));
                        }

                        willClear = false;
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red[900],
                    textColor: Colors.white,
                  );
                } else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                        willClear = true;
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red[900],
                    textColor: Colors.white,
                  );
                } else if (buttons[index] == "ANS") {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = willClear
                            ? "(" + userAnswer + ")"
                            : userQuestion + "(" + userAnswer + ")";
                        willClear = false;
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red[900],
                    textColor: Colors.white,
                  );
                } else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = willClear
                            ? buttons[index]
                            : userQuestion + buttons[index];
                        willClear = false;
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.deepPurple
                        : Colors.deepPurple[50],
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.deepPurple,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    Parser p = Parser();
    try {
       Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
    } catch (e) {
      userQuestion = "ERROR";
    }
   
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
}
