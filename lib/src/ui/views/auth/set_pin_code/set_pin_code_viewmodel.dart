import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/enums/view_state.dart';

final setPinCodeViewModel =
    StateNotifierProvider.autoDispose<SetPinCodeViewModel, SetPinCodeViewState>(
  (ref) => SetPinCodeViewModel(ref.read),
);

class SetPinCodeViewModel extends StateNotifier<SetPinCodeViewState> {
  SetPinCodeViewModel(this._reader) : super(SetPinCodeViewState.initial());

  final Reader _reader;
  final _log = Logger(filter: DevelopmentFilter());

  void goToDashboardView() {
    _reader(navigationProvider).pushNamed(Routes.dashboardView);
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
