import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/themes/theme_modal.dart';
import 'package:todo_app/utils/buttons.dart';

// ignore: must_be_immutable
class EditTaskBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  // final String text;
  VoidCallback onSave;
  VoidCallback onCancel;
  EditTaskBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    // required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return AlertDialog(
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor:
            themeNotifier.isDark ? Colors.yellow : Colors.grey.shade400,
        content: Container(
          padding: const EdgeInsets.only(top: 5),
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                style: const TextStyle(color: Colors.black),
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
                    hintText: 'Edit your task',
                    hintStyle: const TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color:Colors.black
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
