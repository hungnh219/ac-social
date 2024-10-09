import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

const defaultAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/ac-social-internship.appspot.com/o/default_avatar.png?alt=media&token=822ddf23-8cf3-434e-87e3-81fd35491e84";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleAuthProvider _googleProvider = GoogleAuthProvider();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get user => _auth.currentUser;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      User user = _auth.currentUser!;

      // If signed up user not confirm the verify link sent via through gmail
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

  Future<void> signUpWithEmailAndPassword(String email,
      String password) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await userCredential.user!.sendEmailVerification();
      // await userCredential.user!.updatePhotoURL(defaultAvatarUrl);
      // await userCredential.user!.reload();
      // signOut();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
