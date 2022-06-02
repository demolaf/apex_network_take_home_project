import 'package:apex_network_take_home_project/src/ui/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../ui/core/constants/text_styles.dart';

/// SnackBar Provider
final snackBarProvider = Provider(
  (ref) => SnackBarService(),
);

class SnackBarService {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// A custom snack bar to show success message
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
    String text,
  ) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kGreen,
        content: Text(
          text,
          style: AppTextStyles.kBodyMedium,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// A custom snack bar to show error message
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
    String text,
  ) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kRed,
        content: Text(
          text,
          style: AppTextStyles.kBodyMedium,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
