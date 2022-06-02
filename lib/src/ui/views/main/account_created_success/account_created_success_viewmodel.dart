import 'package:apex_network_take_home_project/src/repository/user/user_impl.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/navigation.dart';
import '../../../../services/api/failure.dart';
import '../../../core/enums/view_state.dart';

final accountCreatedSuccessViewModel = StateNotifierProvider.autoDispose<
    AccountCreatedSuccessViewModel, AccountCreatedSuccessViewState>(
  (ref) => AccountCreatedSuccessViewModel(ref.read),
);

class AccountCreatedSuccessViewModel
    extends StateNotifier<AccountCreatedSuccessViewState> {
  AccountCreatedSuccessViewModel(this._reader)
      : super(AccountCreatedSuccessViewState.initial());

  final Reader _reader;
  final _log = Logger(filter: DevelopmentFilter());

  void initialize() async {
    await getFullName();
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
        .pushNamedAndRemoveUntil(Routes.dashboardView, (_) => false);
  }
}

class AccountCreatedSuccessViewState {
  final ViewState viewState;
  final String? fullName;

  const AccountCreatedSuccessViewState._(
      {required this.viewState, this.fullName});

  // initial state of the view
  factory AccountCreatedSuccessViewState.initial() =>
      const AccountCreatedSuccessViewState._(
          viewState: ViewState.idle, fullName: null);

  // using the default state 'idle' if no new state
  AccountCreatedSuccessViewState copyWith(
          {ViewState? viewState, String? fullName}) =>
      AccountCreatedSuccessViewState._(
          viewState: viewState ?? this.viewState,
          fullName: fullName ?? this.fullName);
}
