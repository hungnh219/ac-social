import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/presentation/screens/profile_and_setting/profile_part.dart';
import 'package:social_app/presentation/screens/profile_and_setting/setting_part.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/log_out_button.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/profile_box.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/rounded_icon_image.dart';
import 'package:social_app/utils/constants/icon_path.dart';

import '../../../data/repository/user/user_repository_impl.dart';
import '../../../utils/constants/image_path.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/themes.dart';
import '../../widgets/svg_icon_button.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/setting_cubit.dart';
import 'cubit/setting_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileCubit()..fetchUserData()),
        BlocProvider(create: (context) => SettingCubit()),
      ],
      child: BlocListener<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state is SettingLoggedOut) {
            context.replace('/signin');

          } else if (state is SettingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
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
      ),
    );
  }
}

