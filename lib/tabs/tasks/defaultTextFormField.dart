import 'package:flutter/material.dart';

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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400),
              suffixIcon: suffixicon,),
      maxLines: maxLine,validator:validator,
      
    );
  }
}
