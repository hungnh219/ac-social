import 'package:flutter/material.dart';
import 'package:social_app/utils/styles/colors.dart';

class AuthElevatedButton extends StatelessWidget {
  const AuthElevatedButton(
      {super.key,
      required this.width,
      required this.height,
      required this.inputText,
      this.onPressed,
      required this.isLoading});

  final double width;
  final double height;
  final String inputText;
  final VoidCallback? onPressed;
  final ValueNotifier<bool> isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.iric,
            AppColors.lavenderBlueShadow,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
        child: ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, value, child) {
            return value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    inputText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
