import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/models/auth/create_user_req.dart';
import 'package:social_app/data/models/auth/sign_in_user_req.dart';

import '../../entities/user.dart';

abstract class AuthRepository {
  Future<void> signUp(SignUpUserReq signUpUserReq);

  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq);

  Future<void> signInWithGoogle();

  Future<User?> getCurrentUser();

  Future<void> signOut();

  Future<void> reAuthenticationAndChangeEmail(String email, String newEmail, String password);

  Future<void> updateCurrentUserAvatarUrl(String avatarUrl);
}
