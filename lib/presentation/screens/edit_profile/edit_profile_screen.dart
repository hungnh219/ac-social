import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/edit_profile/widgets/svg_icon_button.dart';
import 'package:social_app/presentation/widgets/edit_profile/app_text_form_field.dart';
import 'package:social_app/presentation/widgets/edit_profile/bottom_rounded_appbar.dart';
import 'package:social_app/utils/constants/image_path.dart';

import '../../../utils/constants/icon_path.dart';
import '../../../utils/styles/themes.dart';
import '../../widgets/edit_profile/gradient_button.dart';

const String avatarURL =
    'https://firebasestorage.googleapis.com/v0/b/ac-social-internship.appspot.com/o/default_avatar.png?alt=media&token=822ddf23-8cf3-434e-87e3-81fd35491e84';

class EditProfile extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {},
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
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  gradient: AppTheme.mainGradient,
                                ),
                                child: SvgIconButton(
                                  // icon: const Icon(Icons.camera_alt_outlined),
                                  iconSize: 18,
                                  onPressed: () {
                                    // Define the action for the button here
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
              ),

              //TODO : Text fields
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextFormField(
                    controller: firstNameController,
                    label: 'First Name',
                    hintText: 'First Name',
                    width: deviceWidth * 0.8,
                  ),
                  const SizedBox(height: 22),
                  AppTextFormField(
                    controller: lastNameController,
                    label: 'Last Name',
                    hintText: 'Last Name',
                    width: deviceWidth * 0.8,
                  ),
                  const SizedBox(height: 22),
                  AppTextFormField(
                    controller: lastNameController,
                    label: 'Email',
                    hintText: 'your_email@gmail.com',
                    width: deviceWidth * 0.8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
        width: deviceWidth * 0.8,
        text: 'SAVE CHANGES',
        onPressed: () {
          // Handle save changes action
        },
      ),
    );
  }
}
