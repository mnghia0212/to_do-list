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

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Row(
        children: [
         
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
          if(task.isPinned)
            const Expanded(
              child: Icon(
                Icons.star_border_purple500,
              )
            ),
          Checkbox(value: task.isCompleted, onChanged: onCompleted)
        ],
      ),
    );
  }
}
