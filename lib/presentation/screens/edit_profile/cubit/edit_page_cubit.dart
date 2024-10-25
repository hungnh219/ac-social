import 'package:bloc/bloc.dart';
import 'package:social_app/data/repository/user/user_repository_impl.dart';

import '../../../../data/sources/firestore/firestore_service.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repository/user/user.dart';
import 'edit_state.dart';


class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository = UserRepositoryImpl();

  UserCubit() : super(UserInitial()) {
    fetchCurrentUser();
  }

  // Fetches the current user data and handles any errors
  Future<void> fetchCurrentUser() async {
    emit(UserLoading());
    try {
      final UserModel? user = await userRepository.getCurrentUserData();
      if (user != null) {
        emit(UserLoaded(user));
      }
    } on CustomFirestoreException catch (error) {
      if (error.code == 'user-firestore-not-exist') {
        emit(UserNotFound());
      } else {
        emit(UserError(error.message ?? 'An unknown error occurred'));
      }
    } catch (e) {
      emit(UserError('Failed to load user data'));
    }
  }
}
