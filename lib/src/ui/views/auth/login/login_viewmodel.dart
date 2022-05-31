import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/enums/view_state.dart';

final loginViewModel =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginViewState>(
  (ref) => LoginViewModel(ref.read),
);

class LoginViewModel extends StateNotifier<LoginViewState> {
  LoginViewModel(this._reader) : super(LoginViewState.initial());

  final Reader _reader;

  void login() {}

  void togglePasswordVisible() {
    state = state.copyWith(passwordVisible: !state.passwordVisible);
  }

  void goToDashboardView() {}

  void goToSignUpView() {
    _reader(navigationProvider).pushNamed(Routes.signupView);
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
