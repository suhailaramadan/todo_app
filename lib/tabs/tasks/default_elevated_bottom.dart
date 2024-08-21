import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class DefaultElevatedBottom extends StatelessWidget {
  DefaultElevatedBottom(
      {super.key, required this.lable, required this.onPressed});
  String lable;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        lable,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 24, fontWeight: FontWeight.w500, color: AppTheme.white),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          fixedSize: Size(MediaQuery.of(context).size.width, 52)),
    );
  }
}
