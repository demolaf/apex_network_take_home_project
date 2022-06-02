import 'package:apex_network_take_home_project/src/ui/core/extensions/validation_extension.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/signup/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/stateless/gap.dart';
import '../../../shared/stateless/text_field.dart';
import '../../../shared/stateless/visibility_toggle.dart';
import '../base_auth/base_auth_view.dart';

class SignupView extends HookConsumerWidget {
  SignupView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(signupViewModel);
    final fullNameController = useTextEditingController();
    final emailTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
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
        headerText: RichText(
          text: TextSpan(
            text: 'Create a',
            style: AppTextStyles.kHeaderRegular.copyWith(
              fontSize: FontSize.s24.sp,
              color: AppColors.kSecondary,
            ),
            children: <TextSpan>[
              const TextSpan(text: ' '),
              TextSpan(
                text: 'Smartpay',
                style: AppTextStyles.kHeaderRegular.copyWith(
                  color: AppColors.kPrimary,
                  fontSize: FontSize.s24.sp,
                ),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: 'account',
                style: AppTextStyles.kHeaderRegular.copyWith(
                  color: AppColors.kSecondary,
                  fontSize: FontSize.s24.sp,
                ),
              ),
            ],
          ),
        ),
        mainActionButtonText: 'Sign Up',
        hasFooterText: true,
        onFooterActionTapped: () {
          ref.read(signupViewModel.notifier).goToLoginView();
        },
        footerTextLeading: 'Already have an account?',
        footerTextTrailing: 'Sign In',
        form: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: 'Full name',
                  controller: fullNameController,
                  textFieldColor: AppColors.kGrey50,
                  keyBoardType: TextInputType.name,
                  validator: context.validateFullName,
                  textStyle: AppTextStyles.kBodySemiBold.copyWith(
                    fontSize: FontSize.s16.sp,
                  ),
                ),
                Gap.md,
                CustomTextField(
                  hintText: 'Email',
                  controller: emailTextController,
                  textFieldColor: AppColors.kGrey50,
                  keyBoardType: TextInputType.emailAddress,
                  validator: context.validateEmail,
                  textStyle: AppTextStyles.kBodySemiBold.copyWith(
                    fontSize: FontSize.s16.sp,
                  ),
                ),
                Gap.md,
                CustomTextField(
                  hintText: 'Password',
                  controller: passwordTextController,
                  textFieldColor: AppColors.kGrey50,
                  obscureText: !viewState.passwordVisible,
                  validator: context.validatePassword,
                  suffixIcon: CustomVisibilityButton(
                    obscureText: viewState.passwordVisible,
                    onTap: () {
                      ref
                          .read(signupViewModel.notifier)
                          .togglePasswordVisible();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        onMainActionButtonTapped: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(signupViewModel.notifier)
              .getEmailToken(email: emailTextController.text)
              .then((value) => ref
                  .read(signupViewModel.notifier)
                  .goToVerifyEmailView()
                  .then((value) async =>
                      await ref.read(signupViewModel.notifier).signup(
                            fullName: fullNameController.text,
                            email: emailTextController.text,
                            password: passwordTextController.text,
                            countryCode:
                                Localizations.localeOf(context).countryCode,
                          )));
        },
        isLoading: viewState.viewState.isLoading,
      ),
    );
  }
}
