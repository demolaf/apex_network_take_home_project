import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/enums/view_state.dart';

final baseAuthViewModel =
    StateNotifierProvider.autoDispose<BaseAuthViewModel, BaseAuthViewState>(
  (ref) => BaseAuthViewModel(ref.read),
);

class BaseAuthViewModel extends StateNotifier<BaseAuthViewState> {
  BaseAuthViewModel(this._reader) : super(BaseAuthViewState.initial());

  final Reader _reader;

  Future<void> loginWithGoogle() async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await Future.delayed(const Duration(seconds: 2)).then((value) =>
          _reader(snackBarProvider)
              .showSuccessSnackBar('Logged in with google successfully'));
      // Add google login functionality
    } catch (e) {
      state = state.copyWith(viewState: ViewState.error);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  Future<void> loginWithApple() async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await Future.delayed(const Duration(seconds: 2)).then((value) =>
          _reader(snackBarProvider)
              .showSuccessSnackBar('Logged in with apple successfully'));
      // Add apple login functionality
    } catch (e) {
      state = state.copyWith(viewState: ViewState.error);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  void goBack() {
    _reader(navigationProvider).pop();
  }
}

class BaseAuthViewState {
  final ViewState viewState;

  const BaseAuthViewState._({required this.viewState});

  // initial state of the view
  factory BaseAuthViewState.initial() =>
      const BaseAuthViewState._(viewState: ViewState.idle);

  // using the default state 'idle' if no new state
  BaseAuthViewState copyWith({ViewState? viewState}) =>
      BaseAuthViewState._(viewState: viewState ?? this.viewState);
}
