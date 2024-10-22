import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/user.dart';
import '../../models/user_firestore/add_user_data.dart';
import '../../models/user_firestore/update_user_req.dart';

abstract class FirestoreService {
  Future<UserModel?>? getUserData();

  Future<UserModel?>? getCurrentUserData();
  // No need add to repository
  Future<UserModel?> fetchUserData();

  Future<void> addCurrentUserData(AddUserReq addUserReq);

  Future<void> updateCurrentUserData(UpdateUserReq updateUserReq);

  Future<List<String>> getUserFollowers(String uid);

  Future<List<String>> getUserFollowings(String uid);

  Future<UserModel?>? getNewUserData();

  Future<UserModel?>? getCurrentNewUserData();
  // No need add to repository
  Future<UserModel?> fetchNewUserData();

  Future<void> addCurrentNewUserData(AddUserReq addUserReq);

}

class FirestoreServiceImpl extends  FirestoreService{
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  CollectionReference get _usersCollection => _firestoreDB.collection('users');

  Future<UserModel?> getUserData() async {
    try {
      return await fetchUserData();
    } on CustomFirestoreException catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
        return null;
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    try {
      return await fetchUserData();
    } on CustomFirestoreException catch (error) {
      if (error.code == 'user-firestore-not-exist') {
        rethrow;
      }
        if (kDebugMode) {
          print(error.toString());
        }
        return null;
      }
  }

  // No need add to repository
  Future<UserModel?> fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await _usersCollection.doc(currentUser?.uid).get();

      if (!userDoc.exists) {
        throw CustomFirestoreException(
          code: 'user-firestore-not-exist',
          message: 'User data does not exist in Firestore',
        );
      }

      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCurrentUserData(AddUserReq addUserReq) async {
    if (currentUser == null) {
      if (kDebugMode) {
        print("No user is currently signed in.");
      }
      return;
    }

    Map<String, dynamic> userData = addUserReq.newUserData.toMap();
    await _usersCollection
        .doc(currentUser?.uid)
        .set(userData)
        .then((value) => print("User Added"))
        .catchError((error) => print("Error pushing user data: $error"));
  }

  Future<void> updateCurrentUserData(UpdateUserReq updateUserReq) async {
    if (currentUser == null) {
      if (kDebugMode) {
        print("No user is currently signed in.");
      }
      return;
    }

    try {
      await _usersCollection.doc(currentUser?.uid).update(updateUserReq.updatedUserData.toMap());
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user data: $e");
      }
    }
  }

  @override
  Future<List<String>> getUserFollowers(String uid) async {
    final followersRef = _firestoreDB
        .collection('users')
        .doc(uid)
        .collection('followers');

    final snapshot = await followersRef.get();

    List<String> followers = snapshot.docs.map((doc) => doc.id).toList();

    return followers;
  }

  Future<List<String>> getUserFollowings(String uid) async {
    final followingRef = _firestoreDB
        .collection('NewUser')
        .doc(uid)
        .collection('followings');

    final snapshot = await followingRef.get();

    List<String> followings = snapshot.docs.map((doc) => doc.id).toList();

    print("the list $uid ${followings.toString()}");

    return followings;
  }

  /////////////////////////////////////////////////////////////////////////

  CollectionReference get _newUsersCollection => _firestoreDB.collection('NewUser');

  Future<UserModel?> getNewUserData() async {
    try {
      return await fetchNewUserData();
    } on CustomFirestoreException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  Future<UserModel?> getCurrentNewUserData() async {
    try {
      return await fetchNewUserData();
    } on CustomFirestoreException catch (error) {
      if (error.code == 'user-firestore-not-exist') {
        rethrow;
      }
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  // No need add to repository
  Future<UserModel?> fetchNewUserData() async {
    try {
      DocumentSnapshot userDoc = await _newUsersCollection.doc("atpFNshDxQOeoPavpluSI2CKrqu2").get();

      if (!userDoc.exists) {
        throw CustomFirestoreException(
          code: 'user-firestore-not-exist',
          message: 'User data does not exist in Firestore',
        );
      }

      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addCurrentNewUserData(AddUserReq addUserReq) async {
    if (currentUser == null) {
      if (kDebugMode) {
        print("No user is currently signed in.");
      }
      return;
    }

    Map<String, dynamic> userData = addUserReq.newUserData.toMap();
    await _usersCollection
        .doc(currentUser?.uid)
        .set(userData)
        .then((value) => print("User Added"))
        .catchError((error) => print("Error pushing user data: $error"));
  }

  //////////////////////////////////////////////////////////////////////////

}

class CustomFirestoreException implements Exception {
  final String code;
  final String message;

  CustomFirestoreException({required this.code, required this.message});

  @override
  String toString() {
    return 'CustomFirestoreException($code): $message';
  }
}
