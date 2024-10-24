import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/domain/entities/user.dart';

import '../../../../utils/constants/icon_path.dart';
import '../../../../utils/styles/colors.dart';
import '../../../../utils/styles/themes.dart';
import '../../../widgets/svg_icon_button.dart';
import '../cubit/profile_cubit.dart';

class ProfileBox extends StatelessWidget {
  const ProfileBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          color: AppColors.white.withOpacity(0.1),
          child: ListTile(
            title: Text(
              'Profile Box',
              style: AppTheme.profileCasualStyle,
            ),
            trailing: SvgIconButton(
              assetPath: AppIcons.editSquare,
              onPressed: () async {
                final Object? result = await context.push('/signin/edit', extra: true);
                if (result is UserModel){
                  if(!result.emailChanged) {
                    context.read<ProfileCubit>().updateProfile(result);
                  }else{
                  context.read<ProfileCubit>().updateProfileWithEmail(result);
                }}
              },
            ),
          ),
        ),
      ),
    );
  }
}