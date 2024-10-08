import 'package:email_validator/email_validator.dart';

mixin Validator {
  String? validateName(String? value, String textFieldTitle) {
    if (value == null || value.isEmpty) {
      return 'Please enter a your $textFieldTitle';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a your username';
    } else if (value.length > 20){
      return 'Your username is too long';
    }
    else if(value.contains(" ")){
      return 'You username must not contain spaces';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty || !EmailValidator.validate(value)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter a your password";
    } else if(value.length < 6){
      return "Password must have more than 5 symbols";
    }
    return null;
  }
}
