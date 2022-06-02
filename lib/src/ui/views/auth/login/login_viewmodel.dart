import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:apex_network_take_home_project/src/repository/user/user_impl.dart';
import 'package:apex_network_take_home_project/src/services/snackbar_service.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../services/api/failure.dart';
import '../../../core/enums/view_state.dart';

final loginViewModel = StateNotifierProvider<LoginViewModel, LoginViewState>(
  (ref) => LoginViewModel(ref.read),
);

class LoginViewModel extends StateNotifier<LoginViewState> {
  LoginViewModel(this._reader) : super(LoginViewState.initial());

  final Reader _reader;

  final _log = Logger(filter: DevelopmentFilter());

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await _reader(authRepository).login(email: email, password: password);
      goToSetPinCodeView();
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
      _reader(snackBarProvider)
          .showErrorSnackBar(e.errors?['email'][0] ?? e.message);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  void togglePasswordVisible() {
    state = state.copyWith(passwordVisible: !state.passwordVisible);
  }

  void goToSetPinCodeView() {
    _reader(userRepository).setIsRegisterFlow(false);
    _reader(navigationProvider)
        .pushNamedAndRemoveUntil(Routes.setPinCodeView, (p0) => false);
  }

  void goToSignUpView() {
    _reader(userRepository).setIsRegisterFlow(true);
    _reader(navigationProvider).pushNamed(Routes.signupView);
  }

  void goToPasswordRecoveryView() {
    _reader(navigationProvider).pushNamed(Routes.passwordRecoveryView);
  }
}

class LoginViewState {
  final ViewState viewState;
  final bool passwordVisible;

  const LoginViewState._(
      {required this.viewState, required this.passwordVisible});

  // initial state of the view
  factory LoginViewState.initial() =>
      const LoginViewState._(viewState: ViewState.idle, passwordVisible: false);

  // using the default state 'idle' if no new state
  LoginViewState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      LoginViewState._(
          viewState: viewState ?? this.viewState,
          passwordVisible: passwordVisible ?? this.passwordVisible);
}
