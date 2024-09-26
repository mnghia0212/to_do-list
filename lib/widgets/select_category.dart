import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/category_provider.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/circle_container.dart';

class SelectCategory extends ConsumerStatefulWidget {
  final Tasks? task;
  const SelectCategory({Key? key, this.task}) : super(key: key);

  @override
  ConsumerState<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends ConsumerState<SelectCategory> {
  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryProvider.notifier).state = widget.task!.category;
      });
    }
    else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryProvider.notifier).state = TaskCategories.others;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(categoryProvider);
    final categories = TaskCategories.values.toList();

    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
              "Category:",
              style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(10),
              Text(
                selectedCategory.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: selectedCategory.color
                ),
              ),
            ],
          ),
          
          const Gap(10),
          Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = categories[index];

                return InkWell(
                  onTap: () {
                    ref.read(categoryProvider.notifier).state = category;
                  },
                  child: CircleContainer(
                    color: backgroundColor(
                        selectedCategory, category, widget.task),
                    child: Icon(
                      category.icon,
                      color: iconColor(selectedCategory, category, widget.task),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Gap(5),
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }

  Color backgroundColor(TaskCategories selectedCategory,
      TaskCategories category, Tasks? task) {
    if (task != null &&
        task.category == category &&
        selectedCategory == task.category) {
      return category.color.withOpacity(1);
    } else if (category == selectedCategory) {
      return category.color.withOpacity(1); 
    } else {
      return category.color.withOpacity(0.3); 
    }
  }

  Color iconColor(
      TaskCategories selectedCategory, TaskCategories category, Tasks? task) {
    if (category == selectedCategory ||
        (task != null && task.category == category)) {
      return Colors.black; 
    }
    return category.color; 
  }
}
