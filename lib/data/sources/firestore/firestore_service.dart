import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/user.dart';
import '../../models/user_firestore/add_user_data.dart';
import '../../models/user_firestore/update_user_req.dart';

abstract class FirestoreService {
  Future<UserModel?>? getUserData(String userID);

  Future<UserModel?>? getCurrentUserData();

  // No need add to repository
  Future<UserModel?> fetchUserData(String userID);

  Future<void> addCurrentUserData(AddUserReq addUserReq);

  Future<void> updateCurrentUserData(UpdateUserReq updateUserReq);

  Future<List<Map<String, String>>> fetchCategoriesData();
}

class FirestoreServiceImpl extends FirestoreService {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  CollectionReference get _usersCollection =>
      _firestoreDB.collection('NewUser');
  CollectionReference get _categoryCollection =>
      _firestoreDB.collection("Category");

  @override
  Future<UserModel?> getUserData(String userID) async {
    try {
      return await fetchUserData(userID);
    } on CustomFirestoreException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      return await fetchUserData(currentUser!.uid);
    } on CustomFirestoreException catch (error) {
      if (error.code == 'new-user') {
        rethrow;
      }
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  // No need add to repository
  @override
  Future<UserModel?> fetchUserData(String userID) async {
    try {
      DocumentSnapshot userDoc = await _usersCollection.doc(userID).get();

      if (!userDoc.exists) {
        throw CustomFirestoreException(
          code: 'new-user',
          message: 'User data does not exist in Firestore',
        );
      }

      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
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

  @override
  Future<void> updateCurrentUserData(UpdateUserReq updateUserReq) async {
    if (currentUser == null) {
      if (kDebugMode) {
        print("No user is currently signed in.");
      }
      return;
    }

    try {
      await _usersCollection
          .doc(currentUser?.uid)
          .update(updateUserReq.updatedUserData.toMap());
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user data: $e");
      }
    }
  }

  @override
  Future<List<Map<String, String>>> fetchCategoriesData() async {
    List<Map<String, String>> categories = [];
    try {
      QuerySnapshot snapshot = await _categoryCollection.get();

      for (var doc in snapshot.docs) {
        if (doc.exists) {}
        categories.add({
          'id': doc.id, // Lấy ID của tài liệu
          'name': doc['name'], // Lấy trường 'name'
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error get category list: $e");
      }
    }
    if (kDebugMode) {
      print(categories);
    }
    return categories;
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
