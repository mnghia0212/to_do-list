import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';
import 'package:todo_app/data/data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: deviceSize.width,
                height: deviceSize.height * 0.3,
                color: colors.primaryFixed,
                child: const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DisplayWhiteText(
                          text: "June 17th 2024",
                          fontSize: 20,
                        ),
                        
                        Gap(10),
                        
                        DisplayWhiteText(
                          text: "My Todo List",
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        )
                      ]),
                ),
              )
            ],
          ),
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const DisplayListOfTasks(
                      tasks: [
                        Tasks(
                          title: "education",
                          note: "note", 
                          time: "July", 
                          date: "19th", 
                          isCompleted: false, 
                          category: TaskCategories.education
                        ),

                        Tasks(
                          title: "title",
                          note: "note", 
                          time: "July", 
                          date: "19th", 
                          isCompleted: false, 
                          category: TaskCategories.health
                        ),

                        Tasks(
                          title: "title",
                          note: "note", 
                          time: "July", 
                          date: "19th", 
                          isCompleted: false, 
                          category: TaskCategories.home
                        ),

                        Tasks(
                          title: "title",
                          note: "note", 
                          time: "July", 
                          date: "19th", 
                          isCompleted: false, 
                          category: TaskCategories.others
                        )
                      ],
                    ),
                    
                    const Gap(20),

                    Text(
                      'Completed tasks',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Gap(20),

                    const DisplayListOfTasks(
                      isCompletedTasks: true,
                      tasks: [
                        Tasks(
                          title: "education",
                          note: "note", 
                          time: "July", 
                          date: "19th", 
                          isCompleted: true, 
                          category: TaskCategories.education
                        ),
                      ],
                    ),


                    
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: DisplayWhiteText(
                  text: 'Add New Task',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
