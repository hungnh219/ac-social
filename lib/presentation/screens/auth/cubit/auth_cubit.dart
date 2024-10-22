import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/repository/auth/auth_repository_impl.dart';

import '../../../../domain/repository/auth/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepository = AuthRepositoryImpl();

  AuthCubit() : super(AuthInitial()) {
    _checkUserStatus();
  }

  void _checkUserStatus() async{
    User? user = await authRepository.getCurrentUser();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }
}
