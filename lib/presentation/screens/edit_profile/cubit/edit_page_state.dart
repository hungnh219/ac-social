import '../../../../domain/entities/user.dart';

abstract class EditPageState {}

class EditPageInitial extends EditPageState {}

class EditPageLoading extends EditPageState {}

class EditPageLoaded extends EditPageState {
  final UserModel user;
  EditPageLoaded(this.user);
}

class EditPageNotFound extends EditPageState {}

class EditPageError extends EditPageState {
  final String message;
  EditPageError(this.message);
}

class EditPageSaving extends EditPageState {}

class EditPageSaved extends EditPageState {
  final UserModel user;
  EditPageSaved(this.user);
}
