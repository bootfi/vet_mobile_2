import 'package:flutter/cupertino.dart';
import './../core.dart';

class ValidationMixin {
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
}
