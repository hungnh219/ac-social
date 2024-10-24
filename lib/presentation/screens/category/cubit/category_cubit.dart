import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/data/models/user_firestore/add_user_data.dart';
import 'package:social_app/data/repository/auth/auth_repository_impl.dart';
import 'package:social_app/domain/entities/user.dart';
import 'package:social_app/presentation/screens/category/cubit/category_state.dart';
import 'package:social_app/service_locator.dart';

import '../../../../domain/repository/auth/auth_repository.dart';
import '../../../../domain/repository/user/user_repository.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(GetCategoryIDInitial());

  AuthRepository authRepository = AuthRepositoryImpl();
  String? _category;

  void getCategoryId(String? categoryId) async {
    if (categoryId == null) {
      emit(GetCategoryIDFailure());
    } else {
      _category = categoryId;
      emit(GetCategoryIDSuccess());
    }
  }

  void addCurrentUserData(BuildContext context) async{
    User? currentUser = await authRepository.getCurrentUser();
    try {
      emit(AddUserLoading());
      UserModel userModel =
          UserModel.newUser(_category!, currentUser!.photoURL, currentUser!.email);
      AddUserReq newUser = AddUserReq(userModel);
      serviceLocator<UserRepository>().addCurrentUserData(newUser);
      emit(AddUserSuccess());
      context.go("/signin/navigator");
    } catch (e) {
      emit(AddUserFailure());
      if (kDebugMode) {
        print("Error add user: $e");
      }
    }
  }
}
