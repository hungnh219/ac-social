abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoggedOut extends SettingState {} // Add this state for logout

class SettingError extends SettingState {
  final String message;
  SettingError(this.message);
}
