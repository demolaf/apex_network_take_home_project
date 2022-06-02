import 'package:apex_network_take_home_project/src/ui/core/constants/colors.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/component_sizes.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/text_styles.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/validation_extension.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/shared/stateless/text_field.dart';
import 'package:apex_network_take_home_project/src/ui/shared/stateless/visibility_toggle.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/base_auth/base_auth_view.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/stateless/gap.dart';

class LoginView extends HookConsumerWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(loginViewModel);
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
            text: 'Hi There! 👋',
            style: AppTextStyles.kHeaderRegular.copyWith(
              fontSize: FontSize.s24.sp,
              color: AppColors.kSecondary,
            ),
            children: <TextSpan>[
              const TextSpan(text: '\n\n'),
              TextSpan(
                text: 'Welcome back, sign in to your account',
                style: AppTextStyles.kBodyRegular.copyWith(
                  fontSize: FontSize.s16.sp,
                  color: AppColors.kGrey500,
                ),
              ),
            ],
          ),
        ),
        form: Form(
          key: _formKey,
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
              Gap.md,
              CustomTextField(
                hintText: 'Password',
                controller: passwordTextController,
                textFieldColor: AppColors.kGrey50,
                keyBoardType: TextInputType.visiblePassword,
                validator: context.validateNotEmptyField,
                obscureText: !viewState.passwordVisible,
                suffixIcon: CustomVisibilityButton(
                  obscureText: viewState.passwordVisible,
                  onTap: () {
                    ref.read(loginViewModel.notifier).togglePasswordVisible();
                  },
                ),
              ),
              Gap.lg,
              GestureDetector(
                onTap: () {
                  ref.read(loginViewModel.notifier).goToPasswordRecoveryView();
                },
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyles.kBodyBold.copyWith(
                    color: AppColors.kPrimary,
                    fontSize: FontSize.s16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        mainActionButtonText: 'Sign in',
        hasFooterText: true,
        isLoading: viewState.viewState.isLoading,
        onFooterActionTapped: () {
          ref.read(loginViewModel.notifier).goToSignUpView();
        },
        footerTextLeading: 'Don’t have an account?',
        footerTextTrailing: 'Sign Up',
        onMainActionButtonTapped: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref.read(loginViewModel.notifier).login(
              email: emailTextController.text.trim(),
              password: passwordTextController.text);
        },
      ),
    );
  }
}
