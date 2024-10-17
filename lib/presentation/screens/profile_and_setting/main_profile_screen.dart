import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:social_app/presentation/screens/profile_and_setting/profile_part.dart';
import 'package:social_app/presentation/screens/profile_and_setting/setting_part.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(menuScreen: SettingPart(), mainScreen: const ProfilePart(),
    angle: 0,
    duration: const Duration(milliseconds: 600),);
  }
}