import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/models/models.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/circle_container.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});
  final Tasks task;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme;
    final noteText = task.note.isEmpty ? "There is no note for this task" : task.note;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
      
              Visibility(
                visible: task.isCompleted,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Completed",
                      style: TextStyle(
                        fontSize: 17
                      ), 
                    ),

                    const Gap(3),

                    Icon(Icons.check_box, color: task.category.color,),
        
                  ],
                ),
              ),
        
              const Gap(30),
        
              CircleContainer(
                color: task.category.color,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    task.category.icon
                  ),
                ),
              ),
        
              const Gap(15),
        
              Text(task.title,
                style: textStyle.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
        
              const Gap(10),
        
              Text("Created on ${task.time}",
                style: const TextStyle(
                  fontSize: 16
                ), 
              ),
        
        
              Visibility(
                visible: !task.isCompleted,
                child: const Gap(10)),
        
              Visibility(
                visible: !task.isCompleted,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Task will be completed on ${task.date}"),
                    const Gap(3),
                    Icon(Icons.check_box, color: task.category.color,)
                  ],
                )
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Divider(
                  thickness: 1.5,
                  color: task.category.color,
                ),
              ),
        
              Text(noteText,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  
                ), 
              ),
            ],
          ),
        ),

        Positioned(
          top: 8,
          right: 8,
          child: 
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,),)
        )
      ] 
    );
  }
}
