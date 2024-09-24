import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) { 
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isDarkTheme') ?? false; // get data
  }

  Future<void> toggleTheme() async {
    state = !state; // chuyển đổi giá trị

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', state); // store data
  }
}
