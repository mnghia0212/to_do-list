import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});
  final Tasks task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: task.category.color.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: task.category.color)),
            child: Center(
              child: Icon(
                task.category.icon,
                color: task.category.color,
              ),
            ),
          ),

          const Gap(15),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(task.title), Text(task.date)],
            ),
          ),
          Checkbox(value: task.isCompleted, onChanged: (value) {})
        ],
      ),
    );
  }
}
