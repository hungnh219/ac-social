import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';

class LinearGradientTitle extends StatelessWidget {
  const LinearGradientTitle(
      {super.key, required this.text, required this.textStyle});

  final String text;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          colors: [
            AppColors.iric,
            AppColors.lavenderBlueShadow,
          ],
        ).createShader(rect);
      },
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
