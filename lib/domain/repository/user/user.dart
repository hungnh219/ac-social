
import 'package:social_app/data/models/user_firestore/add_user_data.dart';
import 'package:social_app/data/models/user_firestore/update_user_req.dart';

import '../../entities/user.dart';

abstract class UserRepository{
  Future<UserModel?>? getUserData();

  Future<UserModel?>? getCurrentUserData();

  Future<void> addCurrentUserData(AddUserReq addUserReq);

  Future<void> updateCurrentUserData(UpdateUserReq updateUserReq);

  Future<List<String>> getUserFollowers(String uid);

  Future<List<String>> getUserFollowings(String uid);


  Future<UserModel?>? getNewUserData();

  Future<UserModel?>? getCurrentNewUserData();

  Future<void> addCurrentNewUserData(AddUserReq addUserReq);
}