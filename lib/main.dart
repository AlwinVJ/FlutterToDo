// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/themes/theme_modal.dart';

void main() async {
  // initializing the hive
  await Hive.initFlutter();
  // Open the box which is actually the database
  var box = await Hive.openBox('taskBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModal(),
      child: Consumer(builder: (context, ThemeModal themeModal, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'To Do Application',
            home: const HomePage(),
            theme: themeModal.isDark
                ? ThemeData.light()
                : ThemeData.dark());
      }),
    );
  }
}
