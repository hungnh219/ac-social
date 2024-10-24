import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/user.dart';

abstract class EditPageState {}

class EditPageInitial extends EditPageState {}

class EditPageLoading extends EditPageState {}
class EditPageLoaded extends EditPageState {
  final UserModel user;
  EditPageLoaded(this.user);
}

class EditPageUpdating extends EditPageState {}

class EditPageAccepted extends EditPageState {
  final UserModel user;

  EditPageAccepted({ required this.user});
}

class EditPageError extends EditPageState {
  final String message;
  EditPageError(this.message);
}
