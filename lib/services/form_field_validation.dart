import 'package:e_commerce_app/utilities/constants.dart';
import 'package:flutter/services.dart';

class FormFieldValidation {
  final Function addError, removeError;
  final List<String> errors;
  final String password;

  FormFieldValidation(
      {this.addError, this.removeError, this.errors, this.password});

  onChangedTextField(value, fieldType) {
    if (fieldType == "email") {
      if (value.isNotEmpty && errors.contains(kEmailNullError)) {
        removeError(kEmailNullError);
      } else if (emailValidatorRegExp.hasMatch(value) &&
          errors.contains(kInvalidEmailError)) {
        removeError(kInvalidEmailError);
      }
      return null;
    } else if (fieldType == "password") {
      if (value.isNotEmpty && errors.contains(kPassNullError)) {
        removeError(kPassNullError);
      } else if (value.length > 5 && errors.contains(kShortPassError)) {
        removeError(kShortPassError);
      }
    } else if (fieldType == "confirm-password") {
      print("confirm password");
      print("Value $value");
      print("Password: ${password}");
      if (value == password && errors.contains(kMatchPassError)) {
        removeError(kMatchPassError);
      }
    } else if (fieldType == "others") {
      if (value.isNotEmpty && errors.contains(kEmptyFieldError)) {
        removeError(kEmptyFieldError);
      }
      return null;
    }
  }

  validateField(value, fieldType) {
    if (fieldType == "email") {
      if (value.isEmpty && !errors.contains(kEmailNullError)) {
        addError(kEmailNullError);
      } else if (!emailValidatorRegExp.hasMatch(value) &&
          !errors.contains(kInvalidEmailError)) {
        addError(kInvalidEmailError);
      }
      // return null;
    } else if (fieldType == "password") {
      if (value.isEmpty && !errors.contains(kPassNullError)) {
        addError(kPassNullError);
        return kPassNullError;
      } else if (value.length < 5 && !errors.contains(kShortPassError)) {
        addError(kShortPassError);
        return kShortPassError;
      }
      // return null;
    } else if (fieldType == "confirm-password") {
      if (value != password && !errors.contains(kMatchPassError)) {
        addError(kMatchPassError);
        return kMatchPassError;
      }
    } else if (fieldType == "others") {
      if (value.isEmpty && !errors.contains(kEmptyFieldError)) {
        addError(kEmptyFieldError);
        return kEmptyFieldError;
      }
    }
    // return null;
  }
}
