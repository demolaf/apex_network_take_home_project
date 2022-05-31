import 'package:apex_network_take_home_project/src/ui/core/constants/colors.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/component_sizes.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/text_styles.dart';
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
  const LoginView({Key? key}) : super(key: key);

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
              const TextSpan(text: '\n'),
              TextSpan(
                text: 'Welcome back, Sign in to your account',
                style: AppTextStyles.kBodyRegular.copyWith(
                  fontSize: FontSize.s16.sp,
                  color: AppColors.kGrey500,
                ),
              ),
            ],
          ),
        ),
        form: Form(
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Email',
                controller: emailTextController,
                textFieldColor: AppColors.kGrey50,
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
                obscureText: !viewState.passwordVisible,
                suffixIcon: CustomVisibilityButton(
                  obscureText: viewState.passwordVisible,
                  onTap: () {
                    ref.read(loginViewModel.notifier).togglePasswordVisible();
                  },
                ),
              ),
            ],
          ),
        ),
        mainActionButtonText: 'Sign in',
        hasFooterText: true,
        hasForgotPassword: true,
        isLoading: viewState.viewState.isLoading,
        onFooterActionTapped: () {
          ref.read(loginViewModel.notifier).goToSignUpView();
        },
        footerTextLeading: 'Don’t have an account?',
        footerTextTrailing: 'Sign Up',
      ),
    );
  }
}
