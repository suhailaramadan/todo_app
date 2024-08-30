import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';

// ignore: must_be_immutable
class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField(
      {super.key,
      required this.controller,
      this.hintText,
      this.maxLine=1,
      this.validator,
      this.isPassword=false,
      this.label,
      this.type=TextInputType.text,
      this.action=TextInputAction.next
      });
  final TextEditingController controller ;
  final String? hintText;
  final int maxLine;
  final String? Function(String?)? validator;
  final bool isPassword;
  final String? label;
  final TextInputType type;
  final TextInputAction action;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return TextFormField(
      textInputAction:widget.action,
      keyboardType:widget.type,
      controller: widget.controller,
      style: TextStyle(
        color:AppTheme.white,
      ),
      decoration: InputDecoration(
        labelText:widget.label,
        labelStyle:Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,fontSize: 20,
            color: settingsProvider.isDark ? AppTheme.white : AppTheme.black) ,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: settingsProvider.isDark ? AppTheme.white : AppTheme.black),
        suffixIcon:widget.isPassword? IconButton(
          onPressed: () {
            isObscure = !isObscure;
            setState(() {});
          },
          icon: Icon(isObscure
              ? Icons. visibility_outlined
              : Icons.visibility_off_outlined ,color:AppTheme.primary,),
        ):null,
      ),
      maxLines: widget.maxLine,
      validator: widget.validator,
      obscureText:isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
