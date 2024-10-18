import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../utils/constants/icon_path.dart';
import '../../../utils/constants/image_path.dart';
import '../../../utils/styles/themes.dart';
import '../../widgets/edit_profile/bottom_rounded_appbar.dart';
import '../../widgets/profile_and_setting/svg_icon_button.dart';

const String avatarURL =
    'https://firebasestorage.googleapis.com/v0/b/ac-social-internship.appspot.com/o/default_avatar.png?alt=media&token=822ddf23-8cf3-434e-87e3-81fd35491e84';

class ProfilePart extends StatefulWidget {
  const ProfilePart({super.key});

  @override
  State<ProfilePart> createState() => _ProfilePartState();
}

class _ProfilePartState extends State<ProfilePart> {
  @override
  Widget build(BuildContext context) {
    // double deviceHeight = MediaQuery.of(context).size.height;
    // double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 200,
                      child: BottomRoundedAppBar(
                        bannerPath: AppImages.editProfileAppbarBackground,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 40),
                    child: IntrinsicHeight(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                ZoomDrawer.of(context)!.toggle();
                              },
                              icon: const Icon(Icons.settings),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '@brunopham',
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
                              radius: 60,
                              child: CachedNetworkImage(
                                imageUrl: avatarURL,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              // 0.3 Avatar height
                              width: 36,
                              height: 36,
                              decoration: AppTheme.gradientIconBoxDecoration,
                              child: SvgIconButton(
                                assetPath: AppIcons.camera,
                                onPressed: () {
                                  //TODO : Change avatar function
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //TODO : Text fields
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
