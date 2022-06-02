import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/navigation.dart';
import '../../../core/routes.dart';

/// OnBoardingViewModel Provider
final onBoardingViewModel = Provider.autoDispose<OnBoardingViewModel>(
  (ref) => OnBoardingViewModel(ref.read),
);

class OnBoardingViewModel extends ChangeNotifier {
  OnBoardingViewModel(this._reader) : super();

  final Reader _reader;

  void goToLoginView() {
    _reader(navigationProvider).pushNamed(Routes.loginView);
  }
}
