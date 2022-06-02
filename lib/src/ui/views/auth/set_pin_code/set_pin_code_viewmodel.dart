import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/repository/user/user_impl.dart';
import 'package:apex_network_take_home_project/src/services/snackbar_service.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../services/api/failure.dart';
import '../../../core/enums/view_state.dart';

/// SetPinCodeViewModel Provider
final setPinCodeViewModel =
    StateNotifierProvider<SetPinCodeViewModel, SetPinCodeViewState>(
  (ref) => SetPinCodeViewModel(ref.read),
);

class SetPinCodeViewModel extends StateNotifier<SetPinCodeViewState> {
  SetPinCodeViewModel(this._reader) : super(SetPinCodeViewState.initial());

  final Reader _reader;
  final _log = Logger(filter: DevelopmentFilter());

  /// Save user pin code to database
  Future<void> setAndSaveUserPinCode({required String pinCode}) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await _reader(userRepository).setUserPinCode(pinCode: pinCode);
      _reader(snackBarProvider).showSuccessSnackBar('Successfully created pin');
    } on Failure catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      _reader(snackBarProvider).showErrorSnackBar('An error occurred');
      _log.e(e);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  /// Check if user in registration flow to determine what view
  /// should be navigated to
  void checkIfRegisterFlowThenNavigate() {
    bool isRegisterFlow = _reader(userRepository).isRegisterFlow;
    if (isRegisterFlow) {
      goToAccountCreatedSuccessView();
    } else {
      goToDashboardView();
    }
  }

  void goToAccountCreatedSuccessView() async {
    _reader(navigationProvider).pushNamed(Routes.accountCreatedSuccessView);
  }

  void goToDashboardView() {
    _reader(navigationProvider)
        .pushNamedAndRemoveUntil(Routes.dashboardView, (p0) => false);
  }
}

class SetPinCodeViewState {
  final ViewState viewState;

  const SetPinCodeViewState._({required this.viewState});

  // initial state of the view
  factory SetPinCodeViewState.initial() =>
      const SetPinCodeViewState._(viewState: ViewState.idle);

  // using the default state 'idle' if no new state
  SetPinCodeViewState copyWith({ViewState? viewState}) =>
      SetPinCodeViewState._(viewState: viewState ?? this.viewState);
}
