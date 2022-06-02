import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/navigation.dart';
import '../../core/routes.dart';

/// StartupViewModel Provider
final startupViewModel = Provider.autoDispose<StartupViewModel>(
  (ref) => StartupViewModel(ref.read),
);

class StartupViewModel extends ChangeNotifier {
  StartupViewModel(this._reader) : super();

  final Reader _reader;

  /// Startup initialization
  void initialize() async {
    await checkLoggedIn();
  }

  /// Check if user is logged in and has a pin saved in app database
  /// then navigating to the appropriate views
  Future<void> checkLoggedIn() async {
    bool isAuthorized = await _reader(authRepository).hasAuthToken();
    bool hasSavedPinCode = await _reader(authRepository).hasPinCode();
    if (isAuthorized && hasSavedPinCode) {
      goToLoginWithPinView();
    } else if (!hasSavedPinCode && isAuthorized) {
      goToSetPinCodeView();
    } else {
      goToOnBoardingView();
    }
  }

  void goToSetPinCodeView() {
    _reader(navigationProvider).pushNamed(Routes.setPinCodeView);
  }

  void goToOnBoardingView() {
    _reader(navigationProvider)
        .pushNamedAndRemoveUntil(Routes.onBoardingView, (_) => false);
  }

  void goToLoginWithPinView() {
    _reader(navigationProvider)
        .pushNamedAndRemoveUntil(Routes.loginWithPinView, (_) => false);
  }
}
