import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application/pages/TaskProvider.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late List<String> tasks;
  final TextEditingController taskController = TextEditingController();
  int editingIndex = -1;

  @override
  void initState() {
    super.initState();
    // Load tasks from TaskProvider
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    tasks = taskProvider.tasks;

    // Load tasks from SharedPreferences
    loadTasks();
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tasks')) {
      setState(() {
        tasks = prefs.getStringList('tasks') ?? [];
      });
    }
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', tasks);
  }

  void addTask() {
    if (taskController.text.isNotEmpty) {
      // Use TaskProvider to add task
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.addTask(taskController.text);

      // Save tasks to SharedPreferences
      saveTasks();

      // Clear the text field
      taskController.clear();

      // Update UI
      setState(() {
        tasks = taskProvider.tasks;
      });
    }
  }

  void editTask(int index) {
    setState(() {
      taskController.text = tasks[index];
      editingIndex = index;
    });
  }

  void updateTask() {
    if (taskController.text.isNotEmpty && editingIndex != -1) {
      setState(() {
        tasks[editingIndex] = taskController.text;
        editingIndex = -1;
      });

      // Use TaskProvider to update task
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.saveTasks();
      taskController.clear();
    }
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);

      // Use TaskProvider to remove task
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.removeTask(index);

      // Save tasks to SharedPreferences
      saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(labelText: 'Tambahkan tugas'),
                  ),
                ),
                IconButton(
                  icon: Icon(editingIndex == -1 ? Icons.add : Icons.check),
                  onPressed: editingIndex == -1 ? addTask : updateTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => editTask(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeTask(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
