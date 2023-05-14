// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/themes/theme_modal.dart';

class MyButtons extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButtons({super.key, required this.text, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
    return MaterialButton(
      elevation: 2,
      onPressed: onPressed,
      color:themeNotifier.isDark?Colors.yellowAccent:Colors.grey.shade500,
      child: Text(text),
    );
  });
}}
