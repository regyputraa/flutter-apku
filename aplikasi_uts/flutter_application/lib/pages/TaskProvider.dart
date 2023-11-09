import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider extends ChangeNotifier {
  List<String> tasks = [];

  TaskProvider(List<String> initialTasks) {
    loadTasks(initialTasks);
  }

  Future<void> loadTasks(List<String> initialTasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tasks = prefs.getStringList('tasks') ?? initialTasks;
    notifyListeners();
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', tasks);
  }

  void addTask(String task) {
    tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void removeTask(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
      saveTasks();
      notifyListeners();
    }
  }
}
