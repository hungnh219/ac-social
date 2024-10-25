import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/data/repository/auth/auth_repository_impl.dart';
import 'package:social_app/data/repository/storage/storate_repository_impl.dart';
import 'package:social_app/domain/repository/auth/auth_repository.dart';
import 'package:social_app/presentation/screens/edit_profile/widgets/header_and_avatar.dart';
import 'package:social_app/presentation/widgets/placeholder.dart';
import 'package:social_app/presentation/widgets/svg_icon_button.dart';
import 'package:social_app/presentation/widgets/edit_profile/app_text_form_field.dart';
import 'package:social_app/presentation/widgets/edit_profile/bottom_rounded_appbar.dart';
import 'package:social_app/utils/constants/image_path.dart';
import 'package:social_app/utils/extensions/updated_field_extension.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repository/storage/storage_repository.dart';
import '../../../utils/constants/icon_path.dart';
import '../../../utils/styles/themes.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/edit_profile/gradient_button.dart';

import 'cubit/edit_page_cubit.dart';
import 'cubit/edit_page_state.dart';

class EditProfile extends StatefulWidget {

  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController ;
  late TextEditingController lastNameController ;
  late TextEditingController emailController;
  late TextEditingController locationController ;

  late ValueNotifier<String> avatarNotifier;

  late FocusNode nameFocus = FocusNode();
  late FocusNode lastNameFocus = FocusNode();
  late FocusNode emailFocus = FocusNode();
  late FocusNode locationFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    locationController = TextEditingController();
    nameFocus = FocusNode();
    lastNameFocus = FocusNode();
    emailFocus = FocusNode();
    locationFocus = FocusNode();
    context.read<EditPageCubit>().loadCurrentUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    locationController.dispose();

    avatarNotifier.dispose();
    super.dispose();
  }

  Future<bool> reAuthenticateAndChangeEmail(BuildContext context, String newEmail, UserModel updatedUser) async {
    try {
      TextEditingController emailController = TextEditingController();
      TextEditingController passwordController = TextEditingController();

      bool? isAuthenticated = await showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Re-authentication Required'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('You need to re-authenticate to change your email.'),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;

                  await context.read<EditPageCubit>()
                        .reAuthenticateAndChangeEmail(context, updatedUser,newEmail, email, password);

                    Navigator.of(dialogContext).pop(true);
                },
                child: const Text('Submit'),
              ),
              TextButton(
                onPressed: () {
                    Navigator.of(dialogContext).pop(false); // Close the dialog after successful re-authentication
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      ) ?? false;


      return isAuthenticated;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Re-authentication failed. Email not updated.')),
      );
      return false;
    }
  }

@override
Widget build(BuildContext context) {
  double deviceHeight = MediaQuery
      .of(context)
      .size
      .height;
  double deviceWidth = MediaQuery
      .of(context)
      .size
      .width;

  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: BlocBuilder<EditPageCubit, EditPageState>(
        builder: (context, state) {
          if (state is EditPageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is EditPageLoaded ) {
            final user = state.user;

            // if (avatarNotifier == null) {
            avatarNotifier = ValueNotifier<String>(user.avatar);
            // }

            if(user.emailChanged){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop(state.user);
              });
              return const SizedBox.shrink();
            }
            else {
              return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom),
                child: Column(
                  children: [
                    // HeaderAndAvatar(avatarURL: user.avatar),
                    HeaderAndAvatar(avatarNotifier: avatarNotifier),

                    //TODO : Text fields
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFormField(
                          controller: nameController,
                          label: 'Name',
                          hintText: user.name.isNotEmpty ? user.name : 'Name',
                          width: deviceWidth * 0.8,
                          focusNode: nameFocus,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(
                                lastNameFocus);
                          },
                        ),
                        const SizedBox(height: 22),
                        AppTextFormField(
                          controller: lastNameController,
                          label: 'Last Name',
                          hintText: user.lastName.isNotEmpty
                              ? user.lastName
                              : 'Last Name',
                          width: deviceWidth * 0.8,
                          focusNode: lastNameFocus,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailFocus);
                          },
                        ),
                        const SizedBox(height: 22),
                        AppTextFormField(
                          controller: emailController,
                          label: 'Email',
                          hintText: user.email.isNotEmpty
                              ? user.email
                              : 'your_email@gmail.com',
                          width: deviceWidth * 0.8,
                          focusNode: emailFocus,
                          onFieldSubmitted: (value) {},
                        ),
                        const SizedBox(height: 22),
                        AppTextFormField(
                          controller: locationController,
                          label: 'Location',
                          hintText: user.location.isNotEmpty
                              ? user.location
                              : 'Your Location',
                          width: deviceWidth * 0.8,
                          focusNode: locationFocus,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailFocus);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            }
          } else {
            return const AppPlaceHolder();
          }
        }),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: CustomFloatingActionButton(
      width: deviceWidth * 0.8,
      text: 'SAVE CHANGES',
      onPressed: () async {
        UserModel updatedUser =
            (context
                .read<EditPageCubit>()
                .state as EditPageLoaded).user;

        String newName = nameController.text;
        String newEmail = emailController.text;
        String lastname = lastNameController.text;
        String location = locationController.text;

            AuthRepository authRepository = AuthRepositoryImpl();
        User? currentUser = await authRepository.getCurrentUser();
        String rawAvatar = avatarNotifier.value;

        bool noChanges = true;

        // if(rawAvatar.isNotEmpty && rawAvatar != updatedUser.avatar){
        //   try{
        //     StorageRepository storageRepository = StorageRepositoryImpl();

        //     File newAvatarFile = File(rawAvatar);

        //
        //     if (!newAvatarFile.existsSync()) {
        //       throw Exception('"File does not exist at path: $rawAvatar"');
        //     }
        //
        //     String? newAvatarUrl =  await storageRepository.uploadAvatar(newAvatarFile,currentUser!.uid);
        //     if (newAvatarUrl!.isNotEmpty && newAvatarUrl != updatedUser.avatar) {
        //       await authRepository.updateCurrentUserAvatarUrl(newAvatarUrl);
        //       updatedUser = updatedUser.copyWith(newAvatar: newAvatarUrl);
        //       noChanges = false;
        //     }
        //   } catch(e){
        //     if (kDebugMode) {
        //       print(e);
        //     }
        //   }
        //
        // }


        if (newName.isNotEmpty && newName != updatedUser.name) {
          updatedUser = updatedUser.copyWith(name: newName);
          noChanges = false;
        }

        if (lastname.isNotEmpty && lastname != updatedUser.lastName) {
          updatedUser = updatedUser.copyWith(lastName: lastname);
          noChanges = false;
        }

        if (location.isNotEmpty && location != updatedUser.location) {
          updatedUser = updatedUser.copyWith(location: location);
          noChanges = false;
        }

        if ((newEmail.isNotEmpty && newEmail != updatedUser.email)) {

          noChanges = false;
          await reAuthenticateAndChangeEmail(context, newEmail, updatedUser);
          // if (!isFinished) {
          //   return;
          // }
          currentUser = await authRepository.getCurrentUser();
          if(currentUser?.email != updatedUser.email){
            updatedUser = updatedUser.copyWith(newEmail: newEmail);
          }
        }

        if (noChanges) {
          CustomAlertDialog(
            titleText: 'No Changes Detected',
            contentText: 'No fields were changed. Please modify some information to save changes.',
            submitFunction: () {
              Navigator.of(context).pop();
            },
            submitButtonText: 'OK',
            cancelFunction: () {},
            cancelButtonText: 'Dismiss',
            showCancelButton: false,
          ).show(context);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop(updatedUser);
          });
        }
      },
    ),
  );
}}
