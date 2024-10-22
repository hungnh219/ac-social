import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:social_app/presentation/screens/profile_and_setting/profile_part.dart';
import 'package:social_app/presentation/screens/profile_and_setting/setting_part.dart';

import '../../../data/repository/user/user_repository_impl.dart';
import '../../../utils/constants/image_path.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/themes.dart';
import 'cubit/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchUserData(),
      child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.settingBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: const Stack(
              children: <Widget>[
                SettingPart(),
                ProfileBox(),
                ProfilePart(),
              ],
            ),
          ),
      ),
    );
  }
}

class ProfileBox extends StatelessWidget {
  const ProfileBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.only(top: 80),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        color: AppColors.white.withOpacity(0.1), // Example color
        child: Center(
          child: Text(
            'Profile Box',
            style: AppTheme.profileCasualStyle,
          ),
        ),
      ),
    );
  }
}