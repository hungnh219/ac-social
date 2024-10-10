import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/data/models/auth/create_user_req.dart';

import '../../../domain/entities/user.dart';
import '../../models/auth/sign_in_user_req.dart';

const defaultAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/ac-social-internship.appspot.com/o/default_avatar.png?alt=media&token=822ddf23-8cf3-434e-87e3-81fd35491e84";

abstract class AuthFirebaseService{
  Future<void> signUp(SignUpUserReq signUpUserReq);

  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq);

  Future<void> signInWithGoogle();

  Future<UserModel?> getUserModel();

  User? getCurrentUser();

  Future<void> signOut();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleAuthProvider _googleProvider = GoogleAuthProvider();

  @override
  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq) async{
    try {
      await _auth.signInWithEmailAndPassword(
          email: signInUserReq.email.trim(), password: signInUserReq.password);

      User user = _auth.currentUser!;
      print(user.displayName);
      if (!user.emailVerified) {
        signOut();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Your account is not verified. Please check your inbox',
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      rethrow;
    }
  }

  @override
  Future<void> signUp(SignUpUserReq signUpUserReq) async{
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: signUpUserReq.email,
        password: signUpUserReq.password,
      );

      await userCredential.user!.sendEmailVerification();
      await userCredential.user!.updatePhotoURL(defaultAvatarUrl);
      // signOut();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserModel() async{
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      User? user = _auth.currentUser;
      CollectionReference usersCollection = firebaseFirestore.collection('users');

      DocumentSnapshot userDoc = await usersCollection.doc(user?.uid).get();

      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        if (kDebugMode) {
          print("User document does not exist.");
        }
        return UserModel.newUser();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user data: $e");
      }
      return null;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        _auth.signInWithPopup(_googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

        // Create a GoogleAuthProvider credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with Google credentials
        await _auth.signInWithCredential(credential);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  User? getCurrentUser() {
      return _auth.currentUser;
  }

}
