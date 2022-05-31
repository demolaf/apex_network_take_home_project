import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:apex_network_take_home_project/src/services/snackbar_service.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../services/api/failure.dart';
import '../../../core/enums/view_state.dart';

final signupViewModel =
    StateNotifierProvider.autoDispose<SignupViewModel, SignupViewState>(
  (ref) => SignupViewModel(ref.read),
);

class SignupViewModel extends StateNotifier<SignupViewState> {
  SignupViewModel(this._reader) : super(SignupViewState.initial());

  final Reader _reader;
  final _log = Logger(filter: DevelopmentFilter());

  Future<void> getEmailToken({required String email}) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      _log.d('Get email token called');
      _reader(authProvider).setEmail(email: email);
      await _reader(authProvider).getEmailToken(email: email);
      goToVerifyEmailView();
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
      _reader(snackBarProvider)
          .showSuccessSnackBar(e.errors?.email?[0] ?? 'An error occurred');
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  Future<void> signup(
      {required String fullName,
      required String email,
      required String password,
      String? countryCode}) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      _log.d('Signup called');
      await _reader(authProvider).signup(
        fullName: fullName,
        email: email,
        password: password,
        countryCode: countryCode,
      );
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
      _reader(snackBarProvider).showSuccessSnackBar(
          '${e.errors?.email?[0] ?? ''}\n${e.errors?.password?[0] ?? ''}');
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  void togglePasswordVisible() {
    state = state.copyWith(passwordVisible: !state.passwordVisible);
  }

  void goToVerifyEmailView() {
    _reader(navigationProvider).pushNamed(Routes.verifyEmailView);
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
