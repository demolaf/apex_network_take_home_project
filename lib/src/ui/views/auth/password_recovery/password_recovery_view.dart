import 'package:apex_network_take_home_project/src/ui/views/auth/password_recovery/password_recovery_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/stateless/text_field.dart';
import '../base_auth/base_auth_view.dart';

class PasswordRecoveryView extends ConsumerWidget {
  const PasswordRecoveryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: BaseAuthenticationView(
        canGoBack: true,
        onMainActionButtonTapped: () {
          ref.read(passwordRecoveryViewModel.notifier).goToResetPasswordView();
        },
        mainActionButtonText: 'Send verification code',
        hasSocialAuth: false,
        form: Form(
          child: Expanded(
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Email',
                  textFieldColor: AppColors.kGrey50,
                  keyBoardType: TextInputType.emailAddress,
                  textStyle: AppTextStyles.kBodySemiBold.copyWith(
                    fontSize: FontSize.s16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading: false,
        headerText: RichText(
          text: TextSpan(
            text: 'Passsword Recovery',
            style: AppTextStyles.kHeaderRegular.copyWith(
              fontSize: FontSize.s24.sp,
              color: AppColors.kSecondary,
            ),
            children: <TextSpan>[
              const TextSpan(text: '\n\n'),
              TextSpan(
                text:
                    'Enter your registered email below to receive password instructions',
                style: AppTextStyles.kBodyRegular.copyWith(
                  fontSize: FontSize.s16.sp,
                  color: AppColors.kGrey500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
