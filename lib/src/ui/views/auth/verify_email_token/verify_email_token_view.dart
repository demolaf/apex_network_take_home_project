import 'package:apex_network_take_home_project/src/ui/core/extensions/validation_extension.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/verify_email_token/verify_email_token_viewmodel.dart';
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

class VerifyEmailTokenView extends HookConsumerWidget {
  VerifyEmailTokenView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(verifyEmailTokenViewModel);
    final otpController = useTextEditingController(
        text: ref.watch(verifyEmailTokenViewModel.notifier).token);
    final otpFocusNode = useFocusNode();
    otpFocusNode.requestFocus();
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kWhite,
        toolbarHeight: 0,
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: BaseAuthenticationView(
        canGoBack: true,
        hasSocialAuth: false,
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
          key: _formKey,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PinCodeTextField(
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
                  showCursor: false,
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
                Gap.lg,
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await ref
                          .read(verifyEmailTokenViewModel.notifier)
                          .resendCode();
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
              ],
            ),
          ),
        ),
        mainActionButtonText: 'Confirm',
        isLoading: viewState.viewState.isLoading,
        onMainActionButtonTapped: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(verifyEmailTokenViewModel.notifier)
              .verifyEmailWithToken(token: otpController.text)
              .then((value) => ref
                  .read(verifyEmailTokenViewModel.notifier)
                  .goToSignupView());
        },
      ),
    );
  }
}
