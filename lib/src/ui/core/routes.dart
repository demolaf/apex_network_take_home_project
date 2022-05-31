import 'dart:io';

import 'package:apex_network_take_home_project/src/ui/views/auth/login/login_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/signup/signup_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/main/onboarding/onboarding_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/startup/startup_view.dart';

/// Routes
class Routes {
  static const startupView = '/startup_view';
  static const onBoardingView = '/on_boarding_view';
  static const loginView = 'login_view';
  static const signupView = 'signup_view';

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
            builder: (_) => const LoginView(),
          );
        case signupView:
          return MaterialPageRoute(
            builder: (_) => const SignupView(),
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
            builder: (_) => const LoginView(),
          );
        case signupView:
          return CupertinoPageRoute(
            builder: (_) => const SignupView(),
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
