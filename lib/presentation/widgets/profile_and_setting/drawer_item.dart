import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Icon? trailingIcon;

  const CustomListTile({
    super.key,
    required this.title,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Circular Std',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.1,
              ),
            ),
          ),
          if (trailingIcon != null)
            Container(
              padding: const EdgeInsets.all(5),
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: trailingIcon,
            ),
        ],
      ),
    );
  }
}
