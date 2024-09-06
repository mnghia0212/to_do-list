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
    final noteText = task.note.isEmpty ? "No note for this task" : task.note;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
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
        
              Visibility(
                visible: !task.isCompleted,
                child: const Gap(10)),
        
              Visibility(
                visible: !task.isCompleted && task.date != null && task.time != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Complete on ${task.date}, ${task.time}"),
                    const Gap(3),
                    Icon(Icons.check_box, color: task.category.color,)
                  ],
                )
              ),

               Visibility(
                visible: task.date == null || task.time == null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(task.date == null && task.time == null)
                      const Text("No date, no time")
                    else if(task.date != null && task.time == null)
                      Text("Complete on ${task.date}")
                    else if(task.date == null && task.time != null)
                      Text("Complete on ${task.date}, ${task.time}")                  
                  ],
                )
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
