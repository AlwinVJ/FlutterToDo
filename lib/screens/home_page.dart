import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/themes/theme_modal.dart';
import 'package:todo_app/utils/addtaskdialogbox.dart';
import 'package:todo_app/utils/edittaskdialoguebox.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // referencing the database or box
  final _myBox = Hive.box('taskBox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  // This function make the change when the checkbox is tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      if (db.toDoList[index][1] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Center(
                child: Text('Congratulations on the completion of your task')),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
    db.updateDatabase();
  }

  // This function helps in saving the new task
  void saveNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
      });
      Navigator.of(context).pop(ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Center(child: Text('The task has been added successfully')),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          duration: const Duration(seconds: 3),
        ),
      ));
      db.updateDatabase();
      _controller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Center(child: Text('Please enter a task description')),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // This function helps in creating new todo tasks
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AddTaskBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: saveNewTask,
          );
        });
  }

  // This function saves the edited task
  void saveEditedTask(int index) {
    if (_controller.text.isNotEmpty) {
      setState(() {
        db.toDoList[index][0] = _controller.text;
      });
      Navigator.of(context).pop(); // Close the edit task dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Center(
            child: Text('The task has been edited successfully'),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      db.updateDatabase();
      _controller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Center(child: Text('Please enter a task description')),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // This function edits an existing task
  void editTask(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EditTaskBox(
            controller: _controller,
            // text:_controller.text,
            onCancel: () => Navigator.of(context).pop(),
            onSave: () => saveEditedTask(index),
          );
        });
  }

  // This function delete the task which once was created by the user
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Center(
              child: Text('The task has been deleted successfully')),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Scaffold(
        backgroundColor:
            themeNotifier.isDark ? Colors.yellow.shade200 : Colors.black54,
        appBar: AppBar(
          backgroundColor:
              themeNotifier.isDark ? Colors.yellow : Colors.black54,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.settings,
                  color: themeNotifier.isDark ? Colors.black : Colors.white,
                ));
          }),
          title: Text(
            'TO DO',
            style: TextStyle(
              color: themeNotifier.isDark ? Colors.black : Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Container(
            color: themeNotifier.isDark ? Colors.yellow : Colors.black54,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                  child: DrawerHeader(
                      child: Row(
                    children: [
                      const Icon(
                        Icons.settings,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Settings',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )),
                ),
                ListTile(
                  leading: Icon(themeNotifier.isDark
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  title:
                      Text(themeNotifier.isDark ? "Light Theme" : "Dark Theme"),
                  trailing: SwitcherButton(
                    value: themeNotifier.isDark ? false : true,
                    onChange: (value) {
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeNotifier.isDark ? Colors.yellow : Colors.black,
          onPressed: createNewTask,
          child: Icon(
            Icons.add,
            color: themeNotifier.isDark ? Colors.black : Colors.white,
          ),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
              editFunction: () => editTask(index),
            );
          },
        ),
      );
    });
  }
}
