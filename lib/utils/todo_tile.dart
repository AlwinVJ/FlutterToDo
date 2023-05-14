// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/themes/theme_modal.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(15),
                backgroundColor: themeNotifier.isDark
                    ? Colors.yellow.shade800
                    : Colors.black,
                onPressed: deleteFunction,
                icon: Icons.delete,
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: themeNotifier.isDark ? Colors.yellow : Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                Text(
                  taskName,
                  style: TextStyle(
                    decorationThickness: 2.0,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor:
                        themeNotifier.isDark ? Colors.black : Colors.red,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    textBaseline: TextBaseline.ideographic,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
