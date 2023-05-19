
import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
   List toDoList = [];

   //referencing the database again
   final _myBox = Hive.box('taskBox');

   // If this is the first time ever the app is loading this function will execute
   void createInitialData (){
    // toDoList = [['Add the task in this space',false]];
    toDoList = [];

    // Remove the initial to-do-item after the user has used the app for the first time ever
    _myBox.delete('TODOLIST');
   }

   // load the data from the data base 
   void loadData (){
    toDoList = _myBox.get('TODOLIST');
   }

   // update the database 
   void updateDatabase (){
    _myBox.put('TODOLIST',toDoList);
   }
}