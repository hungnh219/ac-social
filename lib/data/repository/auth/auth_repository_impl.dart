import 'package:social_app/domain/repository/auth/auth.dart';

import '../../../domain/entities/user.dart';
import '../../../service_locator.dart';
import '../../models/auth/create_user_req.dart';
import '../../models/auth/sign_in_user_req.dart';
import '../../sources/auth/auth_firebase_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq) async {
    return await serviceLocator<AuthFirebaseService>()
        .signInWithEmailAndPassword(signInUserReq);
  }

  @override
  Future<void> signUp(SignUpUserReq signUpUserReq) async {
    return await serviceLocator<AuthFirebaseService>().signUp(signUpUserReq);
  }

  @override
  Future<void> signInWithGoogle() async {
    return await serviceLocator<AuthFirebaseService>().signInWithGoogle();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    return await serviceLocator<AuthFirebaseService>()
        .sendPasswordResetEmail(email);
  }

  @override
  Future<dynamic> getCurrentUser() async {
    return await serviceLocator<AuthFirebaseService>().getCurrentUser();
  }

  @override
  Future<void> signOut() async {
    return await serviceLocator<AuthFirebaseService>().signOut();
  }
}
