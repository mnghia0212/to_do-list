import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/widgets/widgets.dart';

class CreateTaskScreen extends StatelessWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // actions: const [],
        title: const DisplayWhiteText(
          text: "Add a new task", 
          fontSize: 25,
          fontWeight: FontWeight.bold
          
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CommonTextfield(
              labelName: "Task title:", 
              hintText: "Enter task title..."
            ),

            const Gap(30),

            const Row(
              children: [
                Expanded(
                  child: CommonTextfield(labelName: "Date:", hintText: "Enter date...")
                ),

                Gap(15),

                Expanded(
                  child: CommonTextfield(labelName: "Time:", hintText: "Enter time...")
                )
              ],
            ),

            const Gap(30),

            const CommonTextfield(
              labelName: "Note:", 
              hintText: "Take note for this task...",
              maxLines: 5,
            ),
            
            const Gap(30),

            ElevatedButton(
              onPressed: () {}, 
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: DisplayWhiteText(text: "Save"),
              )
              
            )
          ],
        ),
      ),
    
    );
  }
}