import 'package:flutter/material.dart';

import '../../../utils/styles/themes.dart';

class AuthBody extends StatelessWidget {
  const AuthBody(
      {super.key,
      required this.padding,
      required this.marginTop,
      required this.height});

  final double marginTop;
  final double height;
  final Padding padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: padding,
    );
  }
}
