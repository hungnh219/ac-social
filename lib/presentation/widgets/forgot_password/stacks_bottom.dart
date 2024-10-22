import 'package:flutter/material.dart';

class StacksBottom extends StatelessWidget {
  const StacksBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 50,
        ),
        Positioned(
          left: 90,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(82, 82, 199, 0.5),
                  Color.fromRGBO(82, 82, 199, 0.1),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            transform: Matrix4.rotationZ(0.8),
          ),
        ),
        Positioned(
          left: 140,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(82, 82, 199, 0.5),
                  Color.fromRGBO(82, 82, 199, 0.1),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            transform: Matrix4.rotationZ(0.8),
          ),
        ),
        Positioned(
          right: 30,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(82, 82, 199, 0.5),
                  Color.fromRGBO(82, 82, 199, 0.1),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            transform: Matrix4.rotationZ(0.8),
          ),
        ),
      ],
    );
  }
}
