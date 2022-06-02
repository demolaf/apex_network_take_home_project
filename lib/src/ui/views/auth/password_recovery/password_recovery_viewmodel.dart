import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:apex_network_take_home_project/src/services/api/failure.dart';
import 'package:apex_network_take_home_project/src/services/snackbar_service.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/enums/view_state.dart';

/// PasswordRecoveryViewModel Provider
final passwordRecoveryViewModel =
    StateNotifierProvider<PasswordRecoveryViewModel, PasswordRecoveryViewState>(
  (ref) => PasswordRecoveryViewModel(ref.read),
);

class PasswordRecoveryViewModel
    extends StateNotifier<PasswordRecoveryViewState> {
  PasswordRecoveryViewModel(this._reader)
      : super(PasswordRecoveryViewState.initial());

  final Reader _reader;
  final _log = Logger(filter: DevelopmentFilter());

  /// Fetch email token using api, set email and token to be used by reset
  /// password view
  Future<void> sendVerificationCode({required String email}) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      String? token = await _reader(authRepository).getEmailToken(email: email);
      _reader(authRepository).setEmail(email: email);
      _reader(authRepository).setToken(token: token!);
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _reader(snackBarProvider).showErrorSnackBar(e.message);
      _log.e(e);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  Future<void> goToVerifyEmailTokenView() async {
    await _reader(navigationProvider).pushNamed(Routes.verifyEmailTokenView);
  }

  void goToResetPasswordView() {
    _reader(navigationProvider).pushNamed(Routes.resetPasswordView);
  }
}

class PasswordRecoveryViewState {
  final ViewState viewState;

  const PasswordRecoveryViewState._({
    required this.viewState,
  });

  // initial state of the view
  factory PasswordRecoveryViewState.initial() =>
      const PasswordRecoveryViewState._(viewState: ViewState.idle);

  // using the default state 'idle' if no new state
  PasswordRecoveryViewState copyWith(
          {ViewState? viewState,
          bool? passwordVisible,
          bool? confirmPasswordVisible}) =>
      PasswordRecoveryViewState._(viewState: viewState ?? this.viewState);
}
