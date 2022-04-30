// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:my_calculator/colors.dart';

class buildButtons extends StatelessWidget {
  String text;
  final VoidCallback onClicked;
  buildButtons({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = getBgColor(text);
    final textColor = getTextColor(text);

    return Container(
      height: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        padding: const EdgeInsets.all(0),
        color: bgColor,
        splashColor: Colors.purple,
        onPressed: onClicked,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 30.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Color getBgColor(String buttonText) {
    switch (buttonText) {
      case '+':
      case '-':
      case '×':
      case '÷':
      case '=':
      case '(':
      case ')':
        return kMainButtonsColor.withOpacity(0.4);
      case 'AC':
        return kACButtonColor;
      case '⌫':
        return kDelButtonColor;
      default:
        return kNumberButtonsColor;
    }
  }

  Color getTextColor(String buttonText) {
    switch (buttonText) {
      case '+':
      case '-':
      case '×':
      case '÷':
      case '=':
      case '(':
      case ')':
        return kMainButtonsText;
      case 'AC':
        return kACButtonText;
      default:
        return kNumberButtonsText;
    }
  }
}
