import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:social_app/presentation/screens/profile_and_setting/profile_part.dart';
import 'package:social_app/presentation/screens/profile_and_setting/setting_part.dart';
import 'package:social_app/presentation/widgets/scaffold_custom.dart';

import '../../../utils/styles/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      drawerShadowsBackgroundColor: AppColors.iris,
      menuScreen: SettingPart(),
      mainScreen: ProfilePart(),
      angle: 0,
      duration: Duration(milliseconds: 600),
    );
  }
}

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const ZoomDrawer(
//       drawerShadowsBackgroundColor: AppColors.irish,
//       menuScreen: SettingPart(),
//       mainScreen: ProfilePart(),
//       angle: 0,
//       duration: Duration(milliseconds: 600),
//     );
//   }
// }