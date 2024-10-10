import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(AuthInitial()) {
    _checkUserStatus(); // Initial check when cubit is created
  }

  void _checkUserStatus() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    emit(Unauthenticated());
  }
}
