import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:apex_network_take_home_project/src/repository/user/user_impl.dart';
import 'package:apex_network_take_home_project/src/services/snackbar_service.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../services/api/failure.dart';
import '../../../core/enums/view_state.dart';

final loginWithPinViewModel =
    StateNotifierProvider<LoginWithPinViewModel, LoginWithPinViewState>(
  (ref) => LoginWithPinViewModel(ref.read),
);

class LoginWithPinViewModel extends StateNotifier<LoginWithPinViewState> {
  LoginWithPinViewModel(this._reader) : super(LoginWithPinViewState.initial());

  final Reader _reader;

  final _log = Logger(filter: DevelopmentFilter());

  void initialize() async {
    await getFullName();
  }

  Future<bool> loginWithPin({required String pinCode}) async {
    state = state.copyWith(viewState: ViewState.loading);
    bool result = false;
    try {
      result = await _reader(authRepository)
          .verifyPinBeforeLogin(currentPinCode: pinCode);
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
    return result;
  }

  Future<void> getFullName() async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      String? name = await _reader(userRepository).getName();
      state = state.copyWith(fullName: name);
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  void goToDashboardView() {
    _reader(navigationProvider)
        .pushNamedAndRemoveUntil(Routes.dashboardView, (p0) => false);
  }

  Future<void> logout() async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await _reader(authRepository).logout();
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _log.e(e);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  void goToLoginView() {
    _reader(navigationProvider).popAndPushNamed(Routes.loginView);
  }

  void showErrorSnackBar() {
    _reader(snackBarProvider).showErrorSnackBar('Error signing in');
  }
}

class LoginWithPinViewState {
  final ViewState viewState;
  final String? fullName;

  const LoginWithPinViewState._({required this.viewState, this.fullName});

  // initial state of the view
  factory LoginWithPinViewState.initial() =>
      const LoginWithPinViewState._(viewState: ViewState.idle, fullName: null);

  // using the default state 'idle' if no new state
  LoginWithPinViewState copyWith({ViewState? viewState, String? fullName}) =>
      LoginWithPinViewState._(
          viewState: viewState ?? this.viewState,
          fullName: fullName ?? this.fullName);
}
