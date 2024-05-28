import "package:flutter/material.dart";


// Modal bottom sheet widget for adding a new task
class AddTaskModal extends StatelessWidget {
  AddTaskModal({super.key, required this.addTask});

  final Function addTask;
  TextEditingController controller = TextEditingController();

  // Function to handle the button click in the modal
  void _handleOnClick(BuildContext context) {
    final name = controller.text;  // Get text from the textfield
    if (name.isEmpty) {
      return; //Nothing if text is empty
    }
    addTask(name); // Add task by using "addTask" Function var assigned a func in main.dart

    Navigator.pop(context); // Close modal when add task

    // Snackbar notify successfully add task
    const snackBar = SnackBar(
      content: Text('Successfully add a new task !'),
    );
    // Show snackBar message
    ScaffoldMessenger.of(context).showSnackBar(snackBar); 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: "Name a task",
                    labelStyle: const TextStyle(fontSize: 18.0),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                      onPressed: () => _handleOnClick(context), // button add task
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff006E90),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Add task",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ),
              ]),
        ),
      ),
    );
  }
}
