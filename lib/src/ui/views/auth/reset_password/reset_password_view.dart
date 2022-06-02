import 'package:apex_network_take_home_project/src/ui/core/extensions/validation_extension.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/base_auth/base_auth_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/reset_password/reset_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/stateless/gap.dart';
import '../../../shared/stateless/text_field.dart';
import '../../../shared/stateless/visibility_toggle.dart';

class ResetPasswordView extends HookConsumerWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(resetPasswordViewModel);
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kWhite,
        toolbarHeight: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: BaseAuthenticationView(
        canGoBack: true,
        onMainActionButtonTapped: () {},
        mainActionButtonText: 'Create new password',
        hasSocialAuth: false,
        form: Form(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: 'Password',
                  textFieldColor: AppColors.kGrey50,
                  keyBoardType: TextInputType.visiblePassword,
                  validator: context.validatePassword,
                  obscureText: !viewState.passwordVisible,
                  suffixIcon: CustomVisibilityButton(
                    obscureText: viewState.passwordVisible,
                    onTap: () {},
                  ),
                ),
                Gap.md,
                CustomTextField(
                  hintText: 'Confirm password',
                  textFieldColor: AppColors.kGrey50,
                  keyBoardType: TextInputType.visiblePassword,
                  validator: context.validateNotEmptyField,
                  obscureText: !viewState.confirmPasswordVisible,
                  suffixIcon: CustomVisibilityButton(
                    obscureText: viewState.confirmPasswordVisible,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading: false,
        headerText: RichText(
          text: TextSpan(
            text: 'Create New Password',
            style: AppTextStyles.kHeaderRegular.copyWith(
              fontSize: FontSize.s24.sp,
              color: AppColors.kSecondary,
            ),
            children: <TextSpan>[
              const TextSpan(text: '\n\n'),
              TextSpan(
                text:
                    'Please, enter a new password below different from the previous password',
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
