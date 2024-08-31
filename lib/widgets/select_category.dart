import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/providers/category_provider.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/circle_container.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);
    final categories = TaskCategories.values.toList();

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            "Category:",
            style: context.textTheme.titleLarge,
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
                        
                        color: category == selectedCategory 
                              ? category.color.withOpacity(1)
                              : category.color.withOpacity(0.3),
                        child: Icon(
                          category.icon,
                          color: category == selectedCategory
                              ? Colors.black
                              : category.color,
                          
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Gap(5),
                  itemCount: categories.length))
        ],
      ),
    );
  }
}
