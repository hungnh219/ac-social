import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/domain/repository/auth/auth_repository.dart';

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
  Future<User?> getCurrentUser() async {
    return serviceLocator<AuthFirebaseService>().getCurrentUser();
  }

  @override
  Future<void> signOut() async {
    return await serviceLocator<AuthFirebaseService>().signOut();
  }

  @override
  Future<void> updateCurrentUserEmail(String email) async{
    return await serviceLocator<AuthFirebaseService>().updateCurrentUserEmail(email);
  }

  @override
  Future<void> reAuthenticationAndChangeEmail(String email, String newEmail, String password) async{
    return await serviceLocator<AuthFirebaseService>().reAuthenticationAndChangeEmail(email,newEmail, password);
  }

}
