import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/display_text.dart';
import 'package:todo_app/widgets/display_tittle_text.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeProvider);
    //final SharedPreferences prefs = SharedPreferences.getInstance();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.colorScheme.primary,
          title: const DisplayTittleText(
          text: "Setting",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(isLightTheme ? Icons.dark_mode : Icons.light_mode),
                      title: const DisplayText(
                        text: "Theme",
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        // color: Colors.black,
                      ),
                      trailing: Switch(
                        value: isLightTheme,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
