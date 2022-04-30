import 'package:flutter/material.dart';
import 'package:my_calculator/colors.dart';

AppBar appbar(
  BuildContext context,
  String title,
  IconData icon,
  Function() tap,
) {
  return AppBar(
    backgroundColor: kMainButtonsColor.withOpacity(0.2),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w400),
    ),
    actions: [
      IconButton(
        onPressed: tap,
        icon: Icon(icon),
      ),
    ],
  );
}
