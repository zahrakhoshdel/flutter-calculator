// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:my_calculator/colors.dart';

class buildScientificButtons extends StatelessWidget {
  String text;
  final VoidCallback onClicked;
  buildScientificButtons({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(bottom: 5, left: 8),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        color: kMainButtonsColor.withOpacity(0.4),
        splashColor: Colors.purple,
        onPressed: onClicked,
        child: Text(
          text,
          style: const TextStyle(
            color: kMainButtonsText,
            fontSize: 30.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
