import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:apex_network_take_home_project/src/services/api/failure.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/enums/view_state.dart';

final verifyEmailViewModel = StateNotifierProvider.autoDispose<
    VerifyEmailViewModel, VerifyEmailViewState>(
  (ref) => VerifyEmailViewModel(ref.read),
);

class VerifyEmailViewModel extends StateNotifier<VerifyEmailViewState> {
  VerifyEmailViewModel(this._reader) : super(VerifyEmailViewState.initial());

  final Reader _reader;
  final _log = Logger(filter: DevelopmentFilter());

  void goToLoginView() {
    _reader(navigationProvider).pop();
  }

  Future<void> resendCode() async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await _reader(authProvider)
          .getEmailToken(email: _reader(authProvider).email!);
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

class VerifyEmailViewState {
  final ViewState viewState;

  const VerifyEmailViewState._({required this.viewState});

  // initial state of the view
  factory VerifyEmailViewState.initial() =>
      const VerifyEmailViewState._(viewState: ViewState.idle);

  // using the default state 'idle' if no new state
  VerifyEmailViewState copyWith({ViewState? viewState}) =>
      VerifyEmailViewState._(viewState: viewState ?? this.viewState);
}
