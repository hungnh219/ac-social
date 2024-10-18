import 'package:flutter/material.dart';
import 'package:social_app/presentation/widgets/splash/splash_image.dart';
import 'package:social_app/utils/constants/image_path.dart';

//Group hình splash
class SplashImageGroup extends StatelessWidget {
  const SplashImageGroup({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: 325,
      height: 400,
      padding: const EdgeInsets.all(10),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          SplashImage(
            top: 5,
            width: 130,
            height: 130,
            gradient: LinearGradient(colors: [
              Color(0x005151C6),
              Color(0xFF5151C6),
            ]),
          ),
          SplashImage(
            width: 160,
            height: 160,
            top: 25,
            image: DecorationImage(
              image: AssetImage("${AppAssets.splash1}"),
            ),
          ),
          SplashImage(
            width: 135,
            height: 135,
            top: 125,
            left: 5,
            image: DecorationImage(
              image: AssetImage("${AppAssets.splash2}"),
            ),
          ),
          SplashImage(
            width: 135,
            height: 135,
            top: 125,
            right: 5,
            image: DecorationImage(
              image: AssetImage("${AppAssets.splash4}"),
            ),
          ),
          SplashImage(
            top: 250,
            width: 130,
            height: 130,
            gradient: LinearGradient(colors: [
              Color(0xFF5151C6),
              Color(0x005151C6),
            ]),
          ),
          SplashImage(
            width: 160,
            height: 160,
            top: 200,
            image: DecorationImage(
              image: AssetImage("${AppAssets.splash3}"),
            ),
          ),
        ],
      ),
    );
  }
}
