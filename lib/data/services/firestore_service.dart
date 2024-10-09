import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'firebase_auth_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final AuthService _authService;

  FirestoreService({required AuthService authService})
      : _authService = authService;

  CollectionReference get _usersCollection => _firestoreDB.collection('users');

  User? get user => _authService.user;

  Future<MyUser?> getUserData() async {
    try {
      return await fetchUserData();
    } on CustomFirestoreException catch (error) {
      if (error.code == 'user-firestore-not-exist') {
        MyUser newUser = MyUser.newUser();
        addUserData(newUser);
        return newUser;
      } else {
        print(error.toString());
        return null;
      }
    }
  }

  Future<MyUser?> fetchUserData() async {
    if (user == null && kDebugMode) {
      print("No user is currently signed in.");
      return null;
    }

    try {
      DocumentSnapshot userDoc = await _usersCollection.doc(user?.uid).get();

      if (!userDoc.exists) {
        throw CustomFirestoreException(
          code: 'user-firestore-not-exist',
          message: 'User data does not exist in Firestore',
        );
      }

      return MyUser.fromMap(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user data: $e");
      }
      rethrow;
    }
  }

  Future<void> addUserData(MyUser myUser) async {
    if (user == null && kDebugMode) {
      print("No user is currently signed in.");
      return;
    }

    Map<String, dynamic> userData = myUser.toMap();
    await _usersCollection
        .doc(user?.uid)
        .set(userData)
        .then((value) => print("User Added"))
        .catchError((error) => print("Error pushing user data: $error"));
  }

  Future<void> updateUserData(MyUser myUser) async {
    User? user = _authService.user;

    try {
      await _usersCollection.doc(user?.uid).update(myUser.toMap());
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user data: $e");
      }
    }
  }

  Future<void> deleteUserData() async {
    User? user = _authService.user;

    try {
      await _usersCollection.doc(user?.uid).delete();
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting user data: $e");
      }
    }
  }
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
