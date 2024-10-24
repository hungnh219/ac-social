import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/data/models/auth/create_user_req.dart';
import 'package:social_app/data/sources/firestore/firestore_service.dart';

import '../../models/auth/sign_in_user_req.dart';

const defaultAvatarUrl =
    "https://firebasestorage.googleapis.com/v0/b/ac-social-internship.appspot.com/o/default_avatar.png?alt=media&token=822ddf23-8cf3-434e-87e3-81fd35491e84";

abstract class AuthFirebaseService {
  Future<void> signUp(SignUpUserReq signUpUserReq);

  Future<void> signInWithEmailAndPassword(SignInUserReq signInUserReq);

  Future<void> signInWithGoogle();

  Future<void> sendPasswordResetEmail(String email);

  User? getCurrentUser();

  Future<void> signOut();

  Future<void> reAuthenticationAndChangeEmail(String email, String newEmail, String password);

  Future<void> updateAvatarUrl(String avatarUrl);

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

      // if (!user.emailVerified) {
      //   await signOut();
      //   throw FirebaseAuthException(
      //     code: 'email-not-verified',
      //     message: 'Your account is not verified. Please check your inbox',
      //   );
      // }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error ${e.code}");
      }
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
        email: signUpUserReq.email,
        password: signUpUserReq.password,
      );

      await userCredential.user!.sendEmailVerification();
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

    // Future<void> reAuthenticateUser() async {
    //   try {
    //     User? user = _auth.currentUser;
    //
    //     AuthCredential credential = EmailAuthProvider.credential(
    //       email: user!.email!,
    //       password: 'user_password',
    //     );
    //
    //     // Re-authenticate the user
    //     await user.reauthenticateWithCredential(credential);
    //
    //     // After re-authentication, you can update the email
    //     await _updateEmail();
    //   } on FirebaseAuthException catch (e) {
    //     print('Re-authentication error: ${e.message}');
    //   }
    }

  @override
  Future<void> signInWithGoogle() async {
    // await signOut();
    try {
      if (kIsWeb) {
        _auth.signInWithPopup(_googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

        // Create a GoogleAuthProvider credential
        final AuthCredential googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with Google credentials
        UserCredential googleUserCredential =
        await _auth.signInWithCredential(googleCredential);

        // User? currentUser = _auth.currentUser;
        // final userModel = await getUserModel();
        //
        // if (userModel == null) {
        //   throw "new-user";
        // }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      final signInMethod = await _auth.fetchSignInMethodsForEmail(email);

      if (signInMethod.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
      } else {
        throw FirebaseAuthException(
          code: 'email-not-found',
          message: 'Email does not exists',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error send email reset password: $e");
      }

      rethrow;
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

  Future<void> reAuthenticationAndChangeEmail(String email, String newEmail, String password) async{
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        await user.reauthenticateWithCredential(credential).then((userCredential) {
        userCredential.user?.updateEmail(newEmail);
        userCredential.user?.sendEmailVerification();
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw ("The account already exists for that email.");
      } else {
        rethrow;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      rethrow;
    }
  }

  Future<void> updateAvatarUrl(String avatarUrl) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updatePhotoURL(avatarUrl);

        await user.reload();
      } else {
        throw FirebaseAuthException(code: 'no-user-is-currently-signed-in');
      }
    } catch (e) {
      print("Failed to update avatar: $e");
    }
  }

}
