import 'package:apex_network_take_home_project/src/ui/core/extensions/validation_extension.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/password_recovery/password_recovery_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/stateless/text_field.dart';
import '../base_auth/base_auth_view.dart';

class PasswordRecoveryView extends HookConsumerWidget {
  PasswordRecoveryView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(passwordRecoveryViewModel);
    final emailTextController = useTextEditingController();
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: BaseAuthenticationView(
        canGoBack: true,
        onMainActionButtonTapped: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(passwordRecoveryViewModel.notifier)
              .sendVerificationCode(email: emailTextController.text.trim())
              .then((value) => ref
                  .read(passwordRecoveryViewModel.notifier)
                  .goToVerifyEmailTokenView()
                  .then((value) => ref
                      .read(passwordRecoveryViewModel.notifier)
                      .goToResetPasswordView()));
        },
        mainActionButtonText: 'Send verification code',
        hasSocialAuth: false,
        form: Form(
          key: _formKey,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: 'Email',
                  controller: emailTextController,
                  textFieldColor: AppColors.kGrey50,
                  validator: context.validateEmail,
                  keyBoardType: TextInputType.emailAddress,
                  textStyle: AppTextStyles.kBodySemiBold.copyWith(
                    fontSize: FontSize.s16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading: viewState.viewState.isLoading,
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
