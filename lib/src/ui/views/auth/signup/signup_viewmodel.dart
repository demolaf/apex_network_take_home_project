import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:apex_network_take_home_project/src/services/snackbar_service.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../services/api/failure.dart';
import '../../../core/enums/view_state.dart';

final signupViewModel = StateNotifierProvider<SignupViewModel, SignupViewState>(
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
      _reader(authRepository).setEmail(email: email);
      String? token = await _reader(authRepository).getEmailToken(email: email);
      _reader(authRepository).setToken(token: token!);
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
      _reader(snackBarProvider).showErrorSnackBar('An error occurred');
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
      await _reader(authRepository).signup(
        fullName: fullName,
        email: email,
        password: password,
        countryCode: countryCode,
      );
      _reader(snackBarProvider)
          .showSuccessSnackBar('User registered successfully');
      _reader(navigationProvider)
          .pushNamedAndRemoveUntil(Routes.setPinCodeView, (p0) => false);
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
      _reader(snackBarProvider).showErrorSnackBar(
          '${e.message} ${e.errors?['email'] ?? ''}\n${e.errors?['password'] ?? ''}');
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  void togglePasswordVisible() {
    state = state.copyWith(passwordVisible: !state.passwordVisible);
  }

  Future<void> goToVerifyEmailView() async {
    await _reader(navigationProvider).pushNamed(Routes.verifyEmailView);
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
