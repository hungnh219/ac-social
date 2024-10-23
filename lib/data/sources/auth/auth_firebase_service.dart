import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/data/models/auth/create_user_req.dart';

import '../../../domain/entities/user.dart';
import '../../models/auth/sign_in_user_req.dart';

const defaultAvatarUrl =
    "https://firebasestorage.googleapis.com/v0/b/ac-social-internship.appspot.com/o/default_avatar.png?alt=media&token=822ddf23-8cf3-434e-87e3-81fd35491e84";

abstract class AuthFirebaseService {
  Future<void> signUp(SignUpUserReq signUpUserReq);

  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq);

  Future<void> signInWithGoogle();

  Future<UserModel?> getUserModel();

  User? getCurrentUser();

  Future<void> signOut();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleAuthProvider _googleProvider = GoogleAuthProvider();

  @override
  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: signInUserReq.email.trim(),
        password: signInUserReq.password.trim(),
      );

      User user = userCredential.user!;
      print("User đăng nhập: ${user.email}");
      if (!user.emailVerified) {
        await signOut();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Your account is not verified. Please check your inbox',
        );
      }
    } on FirebaseAuthException catch (e) {
      print("mã ${e.code}");
      switch (e.code) {
        case 'email-not-verified':
          throw ('Your account is not verified. Please check your inbox');
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          throw ("Incorrect email or password");
        default:
          throw ("Authentication error: ${e.message}");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      rethrow;
    }
  }

  @override
  Future<void> signUp(SignUpUserReq signUpUserReq) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: signUpUserReq.email.trim(),
        password: signUpUserReq.password.trim(),
      );

      await userCredential.user!.sendEmailVerification(

      );
      await userCredential.user!.updatePhotoURL(defaultAvatarUrl);
      // signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw ("The account already exists for that email.");
      } else {
        throw ("Error");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserModel() async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      User? user = _auth.currentUser;
      CollectionReference usersCollection =
          firebaseFirestore.collection('users');

      DocumentSnapshot userDoc = await usersCollection.doc(user?.uid).get();

      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        if (kDebugMode) {
          print("User document does not exist.");
        }
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
      print("Đã đăng nhập với user ${getCurrentUser()?.email}");
      await signOut();
      print("Đã đăng xuất với user ${getCurrentUser()?.email}");
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
