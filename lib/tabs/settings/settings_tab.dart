import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    return  SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ThemeMode",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: settingsProvider.isDark?AppTheme.white:AppTheme.black),),
                  Switch(value: settingsProvider.isDark
                  , onChanged: (selectedValue){},),
        
                ],),
                Row(children: [
                  Text("Lamguage",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:settingsProvider.isDark?AppTheme.white:AppTheme.black),),
                  
                ],)
              
            ],
          ),
        ),
      ),
    );
  }
}