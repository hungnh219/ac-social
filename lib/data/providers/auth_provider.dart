// providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;
  User? _user;

  AuthProvider(this._authService) {
    // Lắng nghe thay đổi từ Firebase
    _authService.authStateChanges.listen((user) {
      _user = user;
      notifyListeners(); // Thông báo cho UI cập nhật khi trạng thái thay đổi
    });
  }

  User? get user => _user;
  bool get isSignedIn => _user != null;

  Future<void> signIn(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signUp(String email, String password) async {
    await _authService.signUpWithEmailAndPassword(email, password);
  }



  Future<void> signOut() async {
    await _authService.signOut();
  }
}
