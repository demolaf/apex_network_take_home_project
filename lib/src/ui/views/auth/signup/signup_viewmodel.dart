import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/enums/view_state.dart';

final signupViewModel =
    StateNotifierProvider.autoDispose<SignupViewModel, SignupViewState>(
  (ref) => SignupViewModel(ref.read),
);

class SignupViewModel extends StateNotifier<SignupViewState> {
  SignupViewModel(this._reader) : super(SignupViewState.initial());

  final Reader _reader;

  void signup() {}

  void togglePasswordVisible() {
    state = state.copyWith(passwordVisible: !state.passwordVisible);
  }

  void goToLoginView() {
    _reader(navigationProvider).pop();
  }
}

class SignupViewState {
  final ViewState viewState;
  final bool passwordVisible;

  const SignupViewState._(
      {required this.viewState, required this.passwordVisible});

  // initial state of the view
  factory SignupViewState.initial() => const SignupViewState._(
      viewState: ViewState.idle, passwordVisible: false);

  // using the default state 'idle' if no new state
  SignupViewState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      SignupViewState._(
          viewState: viewState ?? this.viewState,
          passwordVisible: passwordVisible ?? this.passwordVisible);
}
