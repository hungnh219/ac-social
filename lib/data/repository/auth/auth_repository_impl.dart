import 'package:social_app/domain/repository/auth/auth.dart';

import '../../../domain/entities/user.dart';
import '../../../service_locator.dart';
import '../../models/auth/create_user_req.dart';
import '../../models/auth/sign_in_user_req.dart';
import '../../sources/auth/firebase_auth_service.dart';

class AuthRepositoryImpl extends AuthRepository {

  @override
  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq) async{
    return await serviceLocator<AuthFirebaseService>().signInWithEmailAndPassword(signInUserReq);
  }

  @override
  Future<void> signUp(SignUpUserReq signUpUserReq) async {
    return await serviceLocator<AuthFirebaseService>().signUp(signUpUserReq);
  }

  @override
  Future<UserModel?> getUser() async {
    return await serviceLocator<AuthFirebaseService>().getUser();
  }

}