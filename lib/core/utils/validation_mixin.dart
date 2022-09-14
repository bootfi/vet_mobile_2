import 'package:flutter/cupertino.dart';

import './../core.dart';

class ValidationMixin {
  String? validateFullName(String? val, BuildContext context) {
    if (val == null || val.trim().isEmpty) {
      return context.locale.fullNameValidation;
    } else if (val.length < 3) {
      return context.locale.fullNameTooShort;
    } else {
      return null;
    }
  }

  String? validateRequiredEmail(String? val, BuildContext context) {
    if (val == null || val.isEmpty) {
      return context.locale.emailRequired;
    } else {
      const emailRegExpString = r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
          r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
      if (!RegExp(emailRegExpString, caseSensitive: false).hasMatch(val)) {
        return context.locale.emailValidation;
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String? val, BuildContext context) {
    if (val!.trim().isEmpty) {
      return context.locale.passwordRequired;
    } else if (val.length < 6) {
      return context.locale.passwordValidation;
    } else if (val.length > 18) {
      return context.locale.passwordTooLong;
    } else {
      return null;
    }
  }

  String? validatePhoneNumber(String? val, BuildContext context) {
    if (val!.length < 9) {
      return context.locale.phoneNumberValidation;
    } else if (!val.startsWith('5')) {
      return context.locale.phoneNumberMustStartWith;
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(
    String? val,
    String password,
    BuildContext context,
  ) {
    if (val!.trim().isEmpty) {
      return context.locale.conPasswordRequired;
    } else if (val.length < 6) {
      return context.locale.passwordValidation;
    } else if (val != password) {
      return context.locale.passwordNotMatch;
    } else {
      return null;
    }
  }

  String? validateAddress(String? val, BuildContext context) {
    if (val == null || val.trim().isEmpty) {
      return context.locale.addressRequired;
    } else if (val.length <= 4) {
      return context.locale.addressTooShort;
    } else {
      return null;
    }
  }
}
