import 'package:flutter/material.dart';

class BottomRoundedAppBar extends StatelessWidget {
  final String bannerPath;

  const BottomRoundedAppBar({super.key, required this.bannerPath});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomRoundedClipper(),
      child: Image.asset(
        bannerPath,
        fit: BoxFit.cover,
      ),
    );
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(0, size.height, 30, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
