import '../enums/view_state.dart';

/// An extension on [ViewState] to indicate states
extension ViewStateExtension on ViewState {
  bool get isLoading => this == ViewState.loading;

  bool get isIdle => this == ViewState.idle;

  bool get isError => this == ViewState.error;
}
