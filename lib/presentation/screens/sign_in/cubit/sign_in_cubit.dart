import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/presentation/screens/sign_in/cubit/sign_in_state.dart';

import '../../../../data/models/auth/sign_in_user_req.dart';
import '../../../../data/sources/firestore/firestore_service.dart';
import '../../../../domain/repository/auth/auth.dart';
import '../../../../domain/repository/auth/auth_repository.dart';
import '../../../../domain/repository/user/user_repository.dart';
import '../../../../service_locator.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void loginWithEmailAndPassword(
      BuildContext context, SignInUserReq signInUserReq) async {
    try {
      if (formKey.currentState!.validate()) {
        emit(SignInLoading());
        await serviceLocator<AuthRepository>()
            .signInWithEmailAndPassword(signInUserReq);
        await serviceLocator<UserRepository>().getCurrentUserData();
        emit(SignInSuccess());
        print('sign in');
        context.go("/signin/navigator");
        // context.go("/signin/home");
      }
    } catch (e) {
      if (e is CustomFirestoreException) {
        if (e.code == 'new-user') {
          emit(SignInSuccess());
          context.go("/signin/category");
        }
      } else {
        emit(SignInFailure());
        _showAlertDialog(context, "Error", e.toString());
      }
    }
  }

  void loginWithGoogle(BuildContext context) async {
    try {
      await serviceLocator<AuthRepository>().signInWithGoogle();
      await serviceLocator<UserRepository>().getCurrentUserData();
      emit(SignInSuccess());
      context.go("/signin/home");
    } catch (e) {
      if (e is CustomFirestoreException) {
        if (e.code == 'new-user') {
          emit(SignInSuccess());
          context.go("/signin/category");
        }
      } else {
        emit(SignInFailure());
        throw Exception(e);
      }
    }
  }

  void _showAlertDialog(BuildContext context, String? title, String? message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "$title",
            textAlign: TextAlign.center,
          ),
          content: Text("$message"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
}
