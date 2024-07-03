import 'package:flutter/material.dart';

enum TaskCategories {
  education(Icons.school, Colors.blueGrey),
  health(Icons.favorite, Colors.orange),
  home(Icons.home, Colors.green),
  personal(Icons.person, Colors.lightBlue),
  shopping(Icons.shopping_bag, Colors.deepOrange),
  social(Icons.people, Colors.brown),
  travel(Icons.flight, Colors.pink),
  work(Icons.work, Colors.amber),
  others(Icons.directions_off, Colors.purple);

  static TaskCategories stringToCategory(String name) {
    try {
      return TaskCategories.values
          .firstWhere((category) => category.name == name);
    } catch (e) {
      return TaskCategories.others;
    }
  }

  final IconData icon;
  final Color color;

  const TaskCategories(this.icon, this.color);
}
