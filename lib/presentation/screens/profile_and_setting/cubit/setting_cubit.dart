import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/screens/profile_and_setting/cubit/setting_state.dart';

import '../../../../data/repository/auth/auth_repository_impl.dart';
import '../../../../domain/repository/auth/auth_repository.dart';

class SettingCubit extends Cubit<SettingState> {
  AuthRepository authRepository = AuthRepositoryImpl();

  SettingCubit() : super(SettingInitial());

  Future<void> signOut() async {
    try {
      await authRepository.signOut();
      emit(SettingLoggedOut());
    } catch (e) {
      emit(SettingError('Logout failed: $e'));
    }
  }
}
