import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/Screens/to-do.dart';
import 'package:StudGo/models/to-doItem.dart';
import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  List<TodoItem> tasks = [];

  List<TodoItem> get task {
    return [...tasks];
  }

  void addTask({String title, String content, String docId}) {
    tasks.insert(
        0,
        TodoItem(
          title: title,
          content: content,
          docId: docId,
          done: false,
        ));
    notifyListeners();
  }

  void deleteTask(String docId) {
    final existingTaskIndex = tasks.indexWhere((task) => task.docId == docId);
    tasks.removeAt(existingTaskIndex);
    notifyListeners();
  }

  void updateTasks(String docId, TodoItem updatedTask) {
    final taskIndex = tasks.indexWhere((task) => task.docId == docId);
    if (taskIndex >= 0) {
      tasks[taskIndex] = updatedTask;
    }
    notifyListeners();
  }

  void getTasks() async {
    final List<TodoItem> loadedTasks = [];
    var doc = await taskRef
        .document(currentUser.email)
        .collection('task')
        .getDocuments();
    doc.documents.forEach((element) {
      print(element.documentID);
      print(element.data);
      loadedTasks.insert(
        0,
        TodoItem(
          title: element.data['title'],
          content: element.data['content'],
          docId: element.documentID,
          done: element.data['done'],
        ),
      );
    });
    tasks = loadedTasks;
    notifyListeners();
  }

  int getDoneCount() {
    int count = 0;
    tasks.forEach((task) {
      if (task.done == true) {
        count++;
      }
    });
    notifyListeners();
    return count;
  }
}
