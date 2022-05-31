import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/navigation.dart';
import '../../core/routes.dart';

/// Start up ViewModel Provider
final startupViewModel = Provider.autoDispose<StartupViewModel>(
  (ref) => StartupViewModel(ref.read),
);

class StartupViewModel extends ChangeNotifier {
  StartupViewModel(this._reader) : super();

  final Reader _reader;

  /// Any startup initialization can be done here
  void initialize() async {
    await Future.delayed(const Duration(seconds: 2)).then(
      (value) => _reader(navigationProvider)
          .pushNamedAndRemoveUntil(Routes.loginView, (_) => false),
    );
  }
}
