import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    return  SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20,vertical:40),
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
                      settingsProvider.changeThemeMode(isDark
                          ? ThemeMode.dark
                          : ThemeMode.light);
                    },
                    activeColor: AppTheme.primary,
                  ),
                ],
              ),
              SizedBox(height: 50,),
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
                      value:settingsProvider.Language,
                      items:[
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
                      dropdownColor:settingsProvider.isDark?AppTheme.black:AppTheme.primary,
                      borderRadius:BorderRadius.circular(18),
                      focusColor:AppTheme.grey,
                      onChanged:(selectedLanguage){
                        if(selectedLanguage==null)return;
                        settingsProvider.changeLanguage(selectedLanguage);
                      }),
                  )
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}