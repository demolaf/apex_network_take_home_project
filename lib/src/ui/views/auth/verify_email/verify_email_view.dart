import 'package:apex_network_take_home_project/src/ui/core/extensions/validation_extension.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/verify_email/verify_email_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/stateless/gap.dart';
import '../base_auth/base_auth_view.dart';

class VerifyEmailView extends HookConsumerWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(verifyEmailViewModel);
    final otpController = useTextEditingController();
    final otpFocusNode = useFocusNode();
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kWhite,
        toolbarHeight: 0,
      ),
      extendBodyBehindAppBar: true,
      body: BaseAuthenticationView(
        canGoBack: true,
        headerText: RichText(
          text: TextSpan(
            text: 'Verify it’s you',
            style: AppTextStyles.kHeaderRegular.copyWith(
              fontSize: FontSize.s24.sp,
              color: AppColors.kSecondary,
            ),
            children: <TextSpan>[
              const TextSpan(text: '\n\n'),
              TextSpan(
                text:
                    'We sent a code to ( *****@mail.com ). Enter it here to verify your identity',
                style: AppTextStyles.kBodyMedium.copyWith(
                  fontSize: FontSize.s16.sp,
                  color: AppColors.kGrey500,
                ),
              ),
            ],
          ),
        ),
        form: Form(
          child: PinCodeTextField(
            appContext: context,
            pastedTextStyle: AppTextStyles.kBodyBold.copyWith(
              fontSize: FontSize.s24,
            ),
            textStyle: AppTextStyles.kBodyBold.copyWith(
              fontSize: FontSize.s24,
            ),
            validator: context.validateOTP,
            length: 5,
            obscureText: false,
            animationType: AnimationType.fade,
            focusNode: otpFocusNode,
            enableActiveFill: true,
            pinTheme: PinTheme(
              selectedColor: AppColors.kPrimary,
              selectedFillColor: AppColors.kGrey50,
              shape: PinCodeFieldShape.box,
              activeColor: AppColors.kPrimary,
              disabledColor: AppColors.kGrey200,
              inactiveColor: Colors.transparent,
              inactiveFillColor: AppColors.kGrey50,
              borderWidth: 1.w,
              borderRadius: BorderRadius.circular(12.r),
              errorBorderColor: Colors.red,
              fieldHeight: 64,
              fieldWidth: 64,
              activeFillColor: AppColors.kGrey50,
            ),
            cursorColor: AppColors.kSecondary,
            animationDuration: const Duration(milliseconds: 300),
            controller: otpController,
            onChanged: (String value) {},
            keyboardType: TextInputType.number,
            beforeTextPaste: (text) {
              if (text != null && int.tryParse(text) != null) {
                return true;
              }
              return false;
            },
          ),
        ),
        mainActionButtonText: 'Confirm',
        customBottomText: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () async {
                  await ref.read(verifyEmailViewModel.notifier).resendCode();
                },
                child: Text(
                  'Resend Code',
                  style: AppTextStyles.kBodyBold.copyWith(
                    color: AppColors.kPrimary,
                    fontSize: FontSize.s16.sp,
                  ),
                ),
              ),
            ),
            Gap.lg,
          ],
        ),
        isLoading: viewState.viewState.isLoading,
        onMainActionButtonTapped: () {},
      ),
    );
  }
}