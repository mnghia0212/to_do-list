import 'package:flutter/material.dart';
import 'package:todo_app/model/tasks.dart';

import 'widget/add_task_modal.dart';
import 'widget/todo_card_widget.dart';

void main(List<String> agrs) {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

// Main widget for the app
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

// State class for MainApp, manage the tasks list
class _MainAppState extends State<MainApp> {

  //Create tasks list
  final List<Tasks> items = [];

  // Function to add new task to list
  void _handleAddTask(String name) {
    // Create a new task with current time as ID
    final newTask = Tasks(taskId: DateTime.now().toString(), taskName: name);
    setState(() {
      items.add(newTask);
    });
  }

  // Function to delete a task from list
  void _handleDeleteTask(String id) {
    setState(() {
      items.removeWhere((item) => item.taskId == id); // Removing task based on ID
    });
    // Snackbar notify successfully delete task
    const snackBar = SnackBar(
      content: Text('Deleted the task'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar); // Show SnackBar
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ToDoList",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff006E90),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: Column(
            children: items
                .map((item) =>
                    TodoCard(
                      index: items.indexOf(item),
                      item: item, 
                      handleDelete: _handleDeleteTask,
                    ))
                .toList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              // Display modal to add a task
              return AddTaskModal(addTask: _handleAddTask); 
            },
          );
        },
        splashColor: const Color.fromARGB(255, 65, 23, 214),
        backgroundColor: const Color(0xff006E90),
        mouseCursor: MaterialStateMouseCursor.textable,
        tooltip: "Add a todo work",
        elevation: 0,
        child: const Icon(
          Icons.add_task,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
