import 'package:apex_network_take_home_project/src/repository/auth/auth_impl.dart';
import 'package:apex_network_take_home_project/src/repository/dashboard/dashboard_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/navigation.dart';
import '../../../../services/api/failure.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/routes.dart';

final dashboardViewModel =
    StateNotifierProvider.autoDispose<DashboardViewModel, DashboardViewState>(
  (ref) => DashboardViewModel(ref.read),
);

class DashboardViewModel extends StateNotifier<DashboardViewState> {
  DashboardViewModel(this._reader) : super(DashboardViewState.initial());

  final Reader _reader;
  final _log = Logger(filter: DevelopmentFilter());

  void initialize() async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      final String? secret =
          await _reader(dashboardRepository).getDashboardSecret();
      state = state.copyWith(secret: secret);
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

  Future<void> signOut() async {
    await _reader(authRepository).logout();
  }
}

class DashboardViewState {
  final ViewState viewState;
  final String? secret;

  const DashboardViewState._({required this.viewState, required this.secret});

  // initial state of the view
  factory DashboardViewState.initial() =>
      const DashboardViewState._(viewState: ViewState.idle, secret: null);

  // using the default state 'idle' if no new state
  DashboardViewState copyWith({ViewState? viewState, String? secret}) =>
      DashboardViewState._(
          viewState: viewState ?? this.viewState,
          secret: secret ?? this.secret);
}
