import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/screens/profile_and_setting/cubit/profile_state.dart';

import '../../../../data/repository/auth/auth_repository_impl.dart';
import '../../../../data/repository/user/user_repository_impl.dart';
import '../../../../domain/repository/auth/auth_repository.dart';
import '../../../../domain/repository/user/user_repository.dart';
import '../../../../service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  AuthRepository authRepository = AuthRepositoryImpl();
  UserRepository userRepository = UserRepositoryImpl();

  ProfileCubit() : super(ProfileLoading());

  Future<void> fetchUserData() async {
    emit(ProfileLoading());
    try {
      final _currentUser = await authRepository.getCurrentUser();
      final userModel = await userRepository.getCurrentNewUserData();

      final userFollowers = await userRepository
          .getUserFollowers("atpFNshDxQOeoPavpluSI2CKrqu2");
      final userFollowings = await userRepository
          .getUserFollowings("atpFNshDxQOeoPavpluSI2CKrqu2");
      // final
      // final userFollowers = await userRepository
      //     .getUserFollowers(_currentUser!.uid);
      // final userFollowings = await userRepository
      //     .getUserFollowings(_currentUser.uid);
      if (userModel != null) {
        emit(ProfileLoaded(userModel, userFollowers, userFollowings));
      } else {
        emit(ProfileError("User data not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
