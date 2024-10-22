import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/user.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel userModel;
  final List<String> userFollowers;
  final List<String> userFollowings;

  ProfileLoaded(this.userModel, this.userFollowers, this.userFollowings);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}


