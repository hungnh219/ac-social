import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/data/models/user_firestore/update_user_req.dart';
import 'package:flutter/material.dart';
import 'package:social_app/data/repository/auth/auth_repository_impl.dart';
import 'package:social_app/data/repository/user/user_repository_impl.dart';
import 'package:social_app/domain/repository/auth/auth_repository.dart';

import '../../../../data/sources/firestore/firestore_service.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repository/user/user_repository.dart';
import 'edit_page_state.dart';

class EditPageCubit extends Cubit<EditPageState> {
  final AuthRepository authRepository = AuthRepositoryImpl();
  final UserRepository userRepository = UserRepositoryImpl();

  EditPageCubit() : super(EditPageInitial()) {
    loadCurrentUserData();
  }

  Future<void> loadCurrentUserData() async {
    emit(EditPageLoading());
    try {
      final userModel = await userRepository.getCurrentUserData();
      if (userModel != null) {
        emit(EditPageLoaded(userModel));
      } else {
        emit(EditPageError("User data not found"));
      }
    } catch (e) {
      emit(EditPageError(e.toString()));
    }
  }

  Future<void> reAuthenticateAndChangeEmail(
      BuildContext context,
      UserModel updatedUser,
      String email,
      String password) async {
    emit(EditPageLoading());
    try {
      print("Changing.....");
      await authRepository.reAuthenticationAndChangeEmail(email, updatedUser.email, password);
      emit(EditPageLoaded(updatedUser)); // Emit the loaded state with new user data
    } catch (e) {
      emit(EditPageError('Re-authentication failed. Email not updated.'));
    }
  }

  Future<void> uploadAvatar(XFile image, String userId) async {
    emit(EditPageLoading());

    try {
      // Upload image to Firebase Storage
      String fileName = 'avatars/$userId/${image.name}';
      UploadTask uploadTask = storage.ref().child(fileName).putFile(File(image.path));

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Update the user's avatar URL in Firestore
      await updateAvatarInFirestore(userId, downloadURL);

      emit(EditPageAvatarUpdated(downloadURL));
    } catch (e) {
      emit(EditPageError('Failed to upload avatar'));
    }
  }

  Future<void> updateAvatarInFirestore(String userId, String avatarUrl) async {
    // Code to update avatar URL in Firestore
  }
}
