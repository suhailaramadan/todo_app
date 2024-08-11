import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  DefaultTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLine,
      this.validator});
  TextEditingController controller = TextEditingController();
  String hintText;
  int? maxLine;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w300)),
      maxLines: maxLine,validator:validator,
    );
  }
}
