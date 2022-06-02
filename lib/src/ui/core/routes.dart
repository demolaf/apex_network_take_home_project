import 'dart:io';

import 'package:apex_network_take_home_project/src/ui/views/auth/login/login_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/login_with_pin/login_with_pin_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/password_recovery/password_recovery_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/reset_password/reset_password_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/set_pin_code/set_pin_code_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/signup/signup_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/verify_email/verify_email_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/main/account_created_success/account_created_success_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/main/onboarding/onboarding_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/home/dashboard/dashboard_view.dart';
import '../views/startup/startup_view.dart';

/// Routes
class Routes {
  static const startupView = '/startup_view';
  static const onBoardingView = '/on_boarding_view';
  static const loginView = 'login_view';
  static const loginWithPinView = 'login_with_pin_view';
  static const signupView = 'signup_view';
  static const passwordRecoveryView = 'password_recovery_view';
  static const verifyEmailView = 'verify_email_view';
  static const resetPasswordView = 'reset_password_view';
  static const setPinCodeView = 'set_pin_code_view';
  static const dashboardView = 'dashboard_view';
  static const accountCreatedSuccessView = 'account_created_success_view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (!Platform.isIOS) {
      switch (settings.name) {
        case startupView:
          return MaterialPageRoute(
            builder: (_) => const StartupView(),
          );
        case onBoardingView:
          return MaterialPageRoute(
            builder: (_) => const OnBoardingView(),
          );
        case loginView:
          return MaterialPageRoute(
            builder: (_) => LoginView(),
          );
        case loginWithPinView:
          return MaterialPageRoute(
            builder: (_) => const LoginWithPinView(),
          );
        case signupView:
          return MaterialPageRoute(
            builder: (_) => SignupView(),
          );
        case verifyEmailView:
          return MaterialPageRoute(
            builder: (_) => VerifyEmailView(),
          );
        case passwordRecoveryView:
          return MaterialPageRoute(
            builder: (_) => PasswordRecoveryView(),
          );
        case resetPasswordView:
          return MaterialPageRoute(
            builder: (_) => const ResetPasswordView(),
          );
        case setPinCodeView:
          return MaterialPageRoute(
            builder: (_) => SetPinCodeView(),
          );
        case dashboardView:
          return MaterialPageRoute(
            builder: (_) => const DashboardView(),
          );
        case accountCreatedSuccessView:
          return MaterialPageRoute(
            builder: (_) => const AccountCreatedSuccessView(),
          );
        default:
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
      }
    } else {
      switch (settings.name) {
        case startupView:
          return CupertinoPageRoute(
            builder: (_) => const StartupView(),
          );
        case onBoardingView:
          return CupertinoPageRoute(
            builder: (_) => const OnBoardingView(),
          );
        case loginView:
          return CupertinoPageRoute(
            builder: (_) => LoginView(),
          );
        case loginWithPinView:
          return CupertinoPageRoute(
            builder: (_) => const LoginWithPinView(),
          );
        case signupView:
          return CupertinoPageRoute(
            builder: (_) => SignupView(),
          );
        case verifyEmailView:
          return CupertinoPageRoute(
            builder: (_) => VerifyEmailView(),
          );
        case passwordRecoveryView:
          return CupertinoPageRoute(
            builder: (_) => PasswordRecoveryView(),
          );
        case resetPasswordView:
          return CupertinoPageRoute(
            builder: (_) => const ResetPasswordView(),
          );
        case setPinCodeView:
          return CupertinoPageRoute(
            builder: (_) => SetPinCodeView(),
          );
        case dashboardView:
          return CupertinoPageRoute(
            builder: (_) => const DashboardView(),
          );
        case accountCreatedSuccessView:
          return CupertinoPageRoute(
            builder: (_) => const AccountCreatedSuccessView(),
          );
        default:
          return CupertinoPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
      }
    }
  }
}
