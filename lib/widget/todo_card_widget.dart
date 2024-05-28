import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';


// Widget represent a single todo card
class TodoCard extends StatelessWidget {
  TodoCard({super.key, 
            required this.item,
            required this.handleDelete,
            required this.index
          });
  
  var item; // For map the items list
  var index; // For classify bg color for each task
  final Function handleDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // Check the index if it's odd or even
          color: (index % 2 == 0) ? const Color.fromRGBO(255, 213, 128, 1) : const Color.fromARGB(255, 112, 83, 63),
          borderRadius: BorderRadius.circular(12)),
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.only(top: 15.0),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              // Display the task name by get the items list
              item.taskName,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  // Check the index if it's odd or even
                  color: (index % 2 == 0) ? Colors.black : Colors.white
              ),
            ),
            InkWell(
              // Display confirm dialog
              onTap: () async {
                if (await confirm(context)) {
                  handleDelete(item.taskId);
                }
                return;
              },
              child: Icon(
                Icons.delete_outline,
                size: 26,
                // Check the index if it's odd or even
                color: (index % 2 == 0) ? Colors.black : Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
