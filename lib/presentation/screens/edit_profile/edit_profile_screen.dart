import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/presentation/screens/edit_profile/widgets/header_and_avatar.dart';
import 'package:social_app/presentation/widgets/placeholder.dart';
import 'package:social_app/presentation/widgets/svg_icon_button.dart';
import 'package:social_app/presentation/widgets/edit_profile/app_text_form_field.dart';
import 'package:social_app/presentation/widgets/edit_profile/bottom_rounded_appbar.dart';
import 'package:social_app/utils/constants/image_path.dart';
import 'package:social_app/utils/extensions/updated_field_extension.dart';

import '../../../domain/entities/user.dart';
import '../../../utils/constants/icon_path.dart';
import '../../../utils/styles/themes.dart';
import '../../widgets/edit_profile/gradient_button.dart';
import '../profile_and_setting/cubit/profile_cubit.dart';
import '../profile_and_setting/cubit/setting_cubit.dart';
import '../profile_and_setting/cubit/setting_state.dart';
import 'cubit/edit_page_cubit.dart';
import 'cubit/edit_page_state.dart';

class EditProfile extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode locationFocus = FocusNode();

  EditProfile({super.key});

  void reAuthenticateAndChangeEmail(BuildContext context, UserModel user,
      Map<String, dynamic> updatedFields) async {

    try{
      TextEditingController emailController = TextEditingController();
      TextEditingController passwordController = TextEditingController();

      await showDialog(
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

                  try {
                    await context
                        .read<EditPageCubit>()
                        .reAuthenticateAndChangeEmail(email, user.email, password);
                  } catch (e) {
                    rethrow;
                  }

                  Navigator.of(dialogContext).pop(); // Close the dialog
                },
                child: const Text('Submit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close the dialog without saving
                },
                child: const Text('Cancel'),
              ),
            ],
          );

        },
      );

      saveChanges(context, user, updatedFields);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Re-authentication failed. Email not updated.')),
      );
    }
  }

  void saveChanges(BuildContext context, UserModel user,
      Map<String, dynamic> updatedFields) {
    if (updatedFields.isNotEmpty) {
      UserModel updatedUser = user.copyWith(
        name: updatedFields.updateField('name', user.name),
        lastName: updatedFields.updateField('lastname', user.lastName),
        newEmail: updatedFields.updateField('email', user.email),
        location: updatedFields.updateField('location', user.location),
      );

      Navigator.of(context).pop(updatedUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      BlocListener<EditPageCubit, EditPageState>(
        listener: (context, state) {
          if (state is EditPageAccepted) {
            Navigator.of(context).pop();
          }
        },
            child: BlocBuilder<EditPageCubit, EditPageState>(builder: (context, state) {
                    if (state is EditPageLoading) {
            return const Center(child: const CircularProgressIndicator());
                    } else if (state is EditPageLoaded) {
            final user = state.user;
            
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    HeaderAndAvatar(avatarURL: user.avatar),
            
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
                            FocusScope.of(context).requestFocus(lastNameFocus);
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
                    } else {
            return const AppPlaceHolder();
                    }
                  }),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
        width: deviceWidth * 0.8,
        text: 'SAVE CHANGES',
        onPressed: () {
          final user =
              (context.read<EditPageCubit>().state as EditPageLoaded).user;

          Map<String, dynamic> updatedFields = {};

          if (nameController.text != user.name) {
            updatedFields['name'] = nameController.text;
          }
          if (lastNameController.text != user.lastName) {
            updatedFields['lastname'] = lastNameController.text;
          }
          if (locationController.text != user.location) {
            updatedFields['location'] = locationController.text;
          }

          if (emailController.text != user.email) {
            updatedFields['email'] = emailController.text;
            reAuthenticateAndChangeEmail(context, user, updatedFields);
          } else {
            saveChanges(context, user,
                updatedFields); // Save changes without email re-authentication
          }
        },
      ),
    );
  }
}
