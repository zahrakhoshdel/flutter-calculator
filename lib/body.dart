import 'package:flutter/material.dart';
import 'package:my_calculator/colors.dart';
import 'package:my_calculator/const.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:my_calculator/history.dart';
import 'package:my_calculator/model.dart/historyitem.dart';
import 'package:my_calculator/widget/appbar.dart';
import 'package:my_calculator/widget/build_buttons.dart';
import 'package:my_calculator/widget/build_scientific_buttons.dart';

String firstOperand = '0';
String secondOperand = '';
String operators = '';
String equation = '0';
String result = '';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<historyItem> myList = [];

  String expression = '';
  double equationFontSize = 35.0;
  double resultFontSize = 25.0;

  void initialise() {}

  void _onPressed(String buttonText) {
    //print(buttonText);
    switch (buttonText) {
      case 'AC':
        setState(() {
          _clear();
        });
        break;

      case '=':
        if (result == '') {
          _result();
        }
        break;
      default:
        _operands(buttonText);
    }
  }

  void _clear() {
    firstOperand = '0';
    secondOperand = '';
    operators = '';
    equation = '0';
    result = '';
    expression = '';
    equationFontSize = 35.0;
    resultFontSize = 25.0;
  }

  void _operands(value) {
    setState(() {
      equationFontSize = 35.0;
      resultFontSize = 25.0;
      switch (value) {
        case '.00':
          if (result != '') {
            firstOperand = (double.parse(result) / 100).toString();
          } else if (operators != '') {
            if (secondOperand != "") {
              if (operators == '+' || operators == '-') {
                secondOperand = ((double.parse(firstOperand) / 100) *
                        double.parse(secondOperand))
                    .toString();
              } else if (operators == '×' || operators == '÷') {
                secondOperand = (double.parse(secondOperand) / 100).toString();
              }
            }
          } else {
            if (firstOperand != "") {
              firstOperand = (double.parse(firstOperand) / 100).toString();
            }
          }
          if (firstOperand.toString().endsWith(".0")) {
            firstOperand =
                int.parse(firstOperand.toString().replaceAll(".0", ""))
                    .toString();
          }
          if (secondOperand.toString().endsWith(".0")) {
            secondOperand =
                int.parse(secondOperand.toString().replaceAll(".0", ""))
                    .toString();
          }
          break;
        case '.':
          if (result != '') _clear();
          if (operators != '') {
            if (!secondOperand.toString().contains(".")) {
              if (secondOperand == "") {
                secondOperand = ".";
              } else {
                secondOperand += ".";
              }
            }
          } else {
            if (!firstOperand.toString().contains(".")) {
              if (firstOperand == "") {
                firstOperand = ".";
              } else {
                firstOperand += ".";
              }
            }
          }
          break;
        case '+':
        case '-':
        case '×':
        case '÷':
          if (firstOperand == '0') {
            if (value == '-') firstOperand = '-';
          } else if (secondOperand == '') {
            operators = value;
          } else {
            _result();
            firstOperand = result;
            operators = value;
            secondOperand = '';
            result = '';
          }
          break;
        default:
          if (operators != '') {
            secondOperand += value;
          } else {
            firstOperand == '0' ? firstOperand = value : firstOperand += value;
          }
          if (value == '%') value = ' mód ';
          if (value == 'X^') value = '^';
          if (value == 'asin') value = 'arcsin';
          if (value == 'acos') value = 'arccos';
          if (value == 'atan') value = 'arctan';
          equation == '0' ? equation = value : equation += value;
        //print('history: $myList');
      }
    });
  }

  void _result() {
    setState(() {
      equationFontSize = 25.0;
      resultFontSize = 35.0;
      expression = firstOperand + operators + secondOperand;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      //expression = equation;
      expression = expression.replaceAll('X^', '^');
      expression = expression.replaceAll(' mód ', '%');
      expression = expression.replaceAll('π', '3.1415926535897932');
      expression = expression.replaceAll('e', 'e^1');
      expression = expression.replaceAll('asin', 'arcsin');
      expression = expression.replaceAll('acos', 'arccos');
      expression = expression.replaceAll('atan', 'arctan');
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        if (result == 'NaN') result = 'Error';
        _isIntResult();

        String hist = '$firstOperand $operators $secondOperand';
        myList.add(
          historyItem(
            expression: hist,
            result: result,
          ),
        );
      } catch (e) {
        result = 'Error';
      }
    });
  }

  _isIntResult() {
    if (result.toString().endsWith(".0")) {
      result = int.parse(result.toString().replaceAll(".0", "")).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Calculator',
        Icons.history,
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => History(myList),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kbgTop,
                  kbgBottom,
                ]),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: calculateField(),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: buildScientificButtonsField(),
                  )),
              Expanded(
                flex: 5,
                child: buildContainerButtonsField(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inOutExpression(text, size, bool isResult) {
    //print('text: $text');
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          isResult
              ? Text('=',
                  style:
                      TextStyle(color: kResultText, fontSize: resultFontSize))
              : Container(),
          Text(
            text is double ? text.toStringAsFixed(2) : text.toString(),
            style: TextStyle(
              color: kResultText,
              fontSize: size,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  Column calculateField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _inOutExpression(firstOperand, equationFontSize, false),
              operators != ''
                  ? _inOutExpression(operators, equationFontSize, false)
                  : Container(),
              secondOperand != ''
                  ? _inOutExpression(secondOperand, equationFontSize, false)
                  : Container(),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              result != ''
                  ? _inOutExpression(result, resultFontSize, true)
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildScientificButtonsField() {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        color: Colors.transparent,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: buttonsScientific.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return buildScientificButtons(
                text: buttonsScientific[index]!,
                onClicked: () {
                  _onPressed(buttonsScientific[index]!);
                },
              );
            }));
  }

  Container buildContainerButtonsField() {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: GridView.count(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 18.0,
          shrinkWrap: false,
          children: buttonsMain.map<Widget>((e) {
            return buildButtons(
              text: e,
              onClicked: () {
                _onPressed(e);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
