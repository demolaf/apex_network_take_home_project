import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:apex_network_take_home_project/src/services/api/failure.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/enums/view_state.dart';

final resetPasswordViewModel =
    StateNotifierProvider<ResetPasswordViewModel, ResetPasswordViewState>(
  (ref) => ResetPasswordViewModel(ref.read),
);

class ResetPasswordViewModel extends StateNotifier<ResetPasswordViewState> {
  ResetPasswordViewModel(this._reader)
      : super(ResetPasswordViewState.initial());

  final Reader _reader;
  final _log = Logger(filter: DevelopmentFilter());

  void goToLoginView() {
    _reader(navigationProvider).pop();
  }

  Future<void> resendCode() async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await _reader(authRepository)
          .getEmailToken(email: _reader(authRepository).email!);
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

class ResetPasswordViewState {
  final ViewState viewState;
  final bool passwordVisible;
  final bool confirmPasswordVisible;

  const ResetPasswordViewState._(
      {required this.viewState,
      required this.passwordVisible,
      required this.confirmPasswordVisible});

  // initial state of the view
  factory ResetPasswordViewState.initial() => const ResetPasswordViewState._(
      viewState: ViewState.idle,
      passwordVisible: false,
      confirmPasswordVisible: false);

  // using the default state 'idle' if no new state
  ResetPasswordViewState copyWith(
          {ViewState? viewState,
          bool? passwordVisible,
          bool? confirmPasswordVisible}) =>
      ResetPasswordViewState._(
          viewState: viewState ?? this.viewState,
          passwordVisible: passwordVisible ?? this.passwordVisible,
          confirmPasswordVisible:
              confirmPasswordVisible ?? this.confirmPasswordVisible);
}
