import 'package:flutter/material.dart';

enum TaskCategories {
  education(Icons.school, Colors.blueGrey),
  health(Icons.favorite, Colors.orange),
  home(Icons.home, Colors.green),
  others(Icons.calendar_month_rounded, Colors.purple),
  personal(Icons.person, Colors.lightBlue),
  shopping(Icons.shopping_bag, Colors.deepOrange),
  social(Icons.people, Colors.brown),
  travel(Icons.flight, Colors.pink),
  work(Icons.work, Colors.amber);


  final IconData icon;
  final Color color;

  const TaskCategories(this.icon, this.color);
}
