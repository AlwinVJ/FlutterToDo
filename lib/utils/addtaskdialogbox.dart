import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/themes/theme_modal.dart';
import 'package:todo_app/utils/buttons.dart';

// ignore: must_be_immutable
class AddTaskBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  AddTaskBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return AlertDialog(
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: themeNotifier.isDark ? Colors.yellow : Colors.black38,
        content: Container(
          padding: const EdgeInsets.only(top: 5),
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Add a new task',
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.clear();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: themeNotifier.isDark
                              ? Colors.black
                              : Colors.white,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButtons(
                      onPressed: onSave,
                      text: 'Save',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    MyButtons(
                      onPressed: onCancel,
                      text: 'Cancel',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
