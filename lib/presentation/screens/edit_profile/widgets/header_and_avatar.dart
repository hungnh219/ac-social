
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/icon_path.dart';
import '../../../../utils/constants/image_path.dart';
import '../../../../utils/styles/themes.dart';
import '../../../widgets/edit_profile/bottom_rounded_appbar.dart';
import '../../../widgets/svg_icon_button.dart';

class HeaderAndAvatar extends StatelessWidget {
  String avatarURL;

  HeaderAndAvatar({super.key, required this.avatarURL});

  double avatarRadius = 60;
  late double appBarBackgroundHeight = avatarRadius * 2 / 0.6;
  late double appBarContainerHeight = avatarRadius * (1 + 2 / 0.6);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 250,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: appBarBackgroundHeight,
              child: const BottomRoundedAppBar(
                bannerPath:
                AppImages.editProfileAppbarBackground,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: ()=>context.pop(),
                      icon: const Icon(Icons.arrow_back_sharp),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Edit profile',
                      textAlign: TextAlign.center,
                      style: AppTheme.headerStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 160,
              height: 120,
              child: Stack(
                children: [
                  Align(
                    child: CircleAvatar(
                      // 0.6 Appbar Background
                      radius: avatarRadius,
                      backgroundImage: CachedNetworkImageProvider(
                        avatarURL,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      // 0.3 Avatar height
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(12)),
                        gradient: AppTheme.mainGradient,
                      ),
                      child: SvgIconButton(
                        iconSize: 18,
                        onPressed: () {
                        },
                        assetPath: AppIcons.camera,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
