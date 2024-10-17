import '../../../../domain/entities/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;
  UserLoaded(this.user);
}

class UserNotFound extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
