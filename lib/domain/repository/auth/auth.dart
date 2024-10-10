import 'package:social_app/data/models/auth/create_user_req.dart';
import 'package:social_app/data/models/auth/sign_in_user_req.dart';

import '../../entities/user.dart';

abstract class AuthRepository{
  Future<void> signUp(SignUpUserReq signUpUserReq);

  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq);

  Future<UserModel?> getUser();
}