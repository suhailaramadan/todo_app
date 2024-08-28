import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.mode,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black),
                  ),
                  Switch(
                    value: settingsProvider.isDark,
                    onChanged: (isDark) {
                      settingsProvider.changeThemeMode(
                          isDark ? ThemeMode.dark : ThemeMode.light);
                    },
                    activeColor: AppTheme.primary,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        value: settingsProvider.Language,
                        items: [
                          DropdownMenuItem(
                            value: "en",
                            child: Text(
                              "English",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: settingsProvider.isDark
                                          ? AppTheme.white
                                          : AppTheme.black),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "ar",
                            child: Text(
                              "العربية",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: settingsProvider.isDark
                                          ? AppTheme.white
                                          : AppTheme.black),
                            ),
                          ),
                        ],
                        dropdownColor: settingsProvider.isDark
                            ? AppTheme.black
                            : AppTheme.primary,
                        borderRadius: BorderRadius.circular(18),
                        focusColor: AppTheme.grey,
                        onChanged: (selectedLanguage) {
                          if (selectedLanguage == null) return;
                          settingsProvider.changeLanguage(selectedLanguage);
                        }),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logout",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black),
                  ),
                  IconButton(
                      onPressed: () {
                        FirebaseFunctions.logout();
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                            Provider.of<TasksProvider>(context,listen: false).tasks.clear();
                            Provider.of<UserProvider>(context,listen: false).updateUser(null);
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 28,
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
