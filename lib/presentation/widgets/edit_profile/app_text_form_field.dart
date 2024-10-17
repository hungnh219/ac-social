import 'package:flutter/material.dart';
import 'package:social_app/utils/styles/themes.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
        required this.controller,
        required this.label,
        required this.hintText,
        required this.width,
        this.suffixIcon,
        this.obscureText = false,
        this.validator,
        this.textInputAction,
        this.textAlign, this.keyboardType});

  final TextEditingController controller;
  final String label;
  final String hintText;
  final double width;
  final IconButton? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTheme.appLabelStyle,),
          const SizedBox(height: 10,),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              suffixIcon: suffixIcon,
            ),
            obscureText: obscureText,
            validator: validator,
            textInputAction: textInputAction,
            textAlign: textAlign ?? TextAlign.start,
          ),
        ],
      ),
    );
  }
}
