import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData.dark(),
      home: Simplecalculator(),
    );
  }
}

class Simplecalculator extends StatefulWidget {
  @override
  _SimplecalculatorState createState() => _SimplecalculatorState();
}

class _SimplecalculatorState extends State<Simplecalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 35.0;
  double resultFontSize = 45.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 35.0;
        resultFontSize = 45.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 45.0;
        resultFontSize = 35.0;

        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 35.0;
        resultFontSize = 45.0;
        expression = equation;
        expression = equation.replaceAll('×', '*');
        expression = equation.replaceAll('÷', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error!!";
        }
      } else {
        equationFontSize = 45.0;
        resultFontSize = 35.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 2, style: BorderStyle.solid)),
          padding: EdgeInsets.all(15.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 15, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 15, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.deepOrange),
                      buildButton("⌫", 1, Colors.red),
                      buildButton("÷", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.grey),
                      buildButton("8", 1, Colors.grey),
                      buildButton("9", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.grey),
                      buildButton("5", 1, Colors.grey),
                      buildButton("6", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.grey),
                      buildButton("2", 1, Colors.grey),
                      buildButton("3", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.grey),
                      buildButton("0", 1, Colors.grey),
                      buildButton("00", 1, Colors.grey),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.green[700]),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
