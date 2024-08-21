import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';

// ignore: must_be_immutable
class DefaultTextFormField extends StatelessWidget {
DefaultTextFormField(
      {super.key,
      required this.controller,
      this.hintText,
      this.maxLine,
      this.validator,
      this.suffixicon
      });
  TextEditingController controller = TextEditingController();
  final String? hintText;
  final int? maxLine;
  final String? Function(String?)? validator;
  final suffixicon;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    return TextFormField(
      textDirection: settingsProvider.Language=="ar"?TextDirection.rtl:TextDirection.ltr,
      controller: controller,
      style: TextStyle(color:settingsProvider.isDark?AppTheme.white:AppTheme.black,),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400,color: settingsProvider.isDark?AppTheme.white:AppTheme.black),
              suffixIcon: suffixicon,),
      maxLines: maxLine,validator:validator,
      
    );
  }
}
