import 'package:bloc/bloc.dart';
import 'package:social_app/data/models/user_firestore/update_user_req.dart';
import 'package:social_app/data/repository/user/user_repository_impl.dart';

import '../../../../data/sources/firestore/firestore_service.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repository/user/user.dart';
import 'edit_page_state.dart';

class EditPageCubit extends Cubit<EditPageState> {
  final UserRepository userRepository = UserRepositoryImpl();

  EditPageCubit() : super(EditPageInitial()) {
    fetchCurrentUserToProfilePage();
  }

  // Fetch user data
  Future<void> fetchCurrentUserToProfilePage() async {
    emit(EditPageLoading());
    try {
      final UserModel? user = await userRepository.getCurrentUserData();
      if (user != null) {
        emit(EditPageLoaded(user));
      } else {
        emit(EditPageNotFound());
      }
    } on CustomFirestoreException catch (error) {
      if (error.code == 'user-firestore-not-exist') {
        emit(EditPageNotFound());
      } else {
        emit(EditPageError(error.message ?? 'An unknown error occurred'));
      }
    } catch (e) {
      emit(EditPageError('Failed to load user data'));
    }
  }

  // Save user data changes
  // Future<void> saveUserChanges(UpdateUserReq user, UserModel currentUser) async {
  //   currentUser = currentUser.copyWith(user.);
  //   try {
  //     emit(EditPageSaving());
  //     await userRepository.updateCurrentUserData(user);
  //     emit(EditPageSaved(user));
  //   } catch (e) {
  //     emit(EditPageError('Failed to save user data'));
  //   }
  // }

  // Future<String> sendAvatarToFirebaseStorage(
  //     dynamic image, String fileName) async {
  //   if (image != null && fileName != "") {
  //     String UID = auth.currentUser!.uid;
  //     UploadTask uploadTask;
  //     Reference storageReference =
  //     FirebaseStorage.instance.ref().child('userAvatar/$UID');
  //
  //     if (kIsWeb) {
  //       SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  //       uploadTask = storageReference.putData(image, metadata);
  //     } else {
  //       uploadTask = storageReference.putFile(image);
  //     }
  //
  //     await uploadTask.whenComplete(() => null);
  //     String? downloadUrl = await storageReference.getDownloadURL();
  //
  //     return downloadUrl;
  //   } else {
  //     return "";
  //   }
  // }
}
