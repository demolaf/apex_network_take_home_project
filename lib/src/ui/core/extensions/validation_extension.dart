import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This extension is for form validations using the [FormKey] approach
/// Import this file in any form view and call the methods from the [Buildcontext]'s
/// [context] variable
///
/// This extension still needs improvement
extension ValidationExtension on BuildContext {
  String? validateEmail(String? email) {
    if (email!.isEmpty) return 'Email address is required';

    bool isEmailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.trim());

    return (isEmailValid) ? null : 'Please enter a valid email';
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) return 'Password is required';

    bool isPasswordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{6,}$').hasMatch(password);

    return (isPasswordValid)
        ? null
        : 'The password must contain at least one uppercase and one lowercase '
            'letter.\nThe password must contain at least one letter.\n'
            'The password must be at least 6 characters.';
  }

  String? validateNotEmptyField(String? input) {
    if (input!.isEmpty) {
      return 'This field cannot be empty';
    } else {
      return null;
    }
  }

  String? validatePinCode(String? input) {
    if (input!.isEmpty) return 'Pin code is required';

    bool isPinCodeValid = input.length == 5;

    return (isPinCodeValid) ? null : 'Please enter a valid pin code';
  }

  String? validateFullName(String? input) {
    if (input!.isEmpty) {
      return 'Full name is required';
    } else {
      return null;
    }
  }

  String? validateOTP(String? otpCode) {
    if (otpCode!.isEmpty) return 'OTP code is required';

    bool isOTPValid = otpCode.length == 5;

    return (isOTPValid) ? null : 'Please enter a valid OTP code';
  }
}
