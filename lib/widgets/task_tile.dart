import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/widgets.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.onCompleted});
  final Tasks task;
  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    //final double iconOpacity = task.isCompleted ? 0.3 : 1;

    final double backgroundOpacity = task.isCompleted ? 0.3 : 0.9;

    final textDecoration =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;

    return Row(
      children: [
        Checkbox(value: task.isCompleted, onChanged: onCompleted),
        CircleContainer(
          color: task.category.color.withOpacity(backgroundOpacity),
          child: Center(
            child: Icon(
              task.category.icon,
            ),
          ),
        ),
    
        const Gap(15),
    
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title,
                  style: style.titleMedium?.copyWith(
                      decoration: textDecoration,
                      fontWeight: FontWeight.bold)),
              Text(task.date,
                  style:
                      style.bodyMedium?.copyWith(decoration: textDecoration)),
            ],
          ),
        ),
        const Gap(80),
        if(task.isPinned && !task.isCompleted)
          Expanded(
            child: Image.asset(
              'lib/assets/icon/push-pin.png',
              width: 50,
              height: 50,
            )
        ),
        
      ],
    );
  }
}
