import 'package:apex_network_take_home_project/src/ui/core/extensions/validation_extension.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/shared/stateless/gap.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/login_with_pin/login_with_pin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../base_auth/base_auth_view.dart';

class LoginWithPinView extends StatefulHookConsumerWidget {
  const LoginWithPinView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginWithPinViewState();
}

class _LoginWithPinViewState extends ConsumerState<LoginWithPinView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref.read(loginWithPinViewModel.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(loginWithPinViewModel);
    final pinController = useTextEditingController();
    final pinFocusNode = useFocusNode();
    pinFocusNode.requestFocus();
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
        canGoBack: false,
        hasSocialAuth: false,
        headerText: RichText(
          text: TextSpan(
            text:
                'Hi ${ref.watch(loginWithPinViewModel).fullName?.split(' ')[0].trim()}! 👋',
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
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 72.w,
                  color: AppColors.kGrey300,
                ),
                Gap.lg,
                Text(
                  '${ref.watch(loginWithPinViewModel).fullName}',
                  style: AppTextStyles.kBodyMedium.copyWith(
                    fontSize: FontSize.s20.sp,
                  ),
                ),
                Gap.md,
                PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: AppTextStyles.kBodyBold.copyWith(
                    fontSize: FontSize.s24.sp,
                  ),
                  textStyle: AppTextStyles.kBodyBold.copyWith(
                    fontSize: FontSize.s24.sp,
                  ),
                  validator: context.validateOTP,
                  length: 5,
                  obscureText: true,
                  animationType: AnimationType.fade,
                  focusNode: pinFocusNode,
                  enableActiveFill: true,
                  pinTheme: PinTheme(
                    selectedColor: AppColors.kPrimary,
                    selectedFillColor: AppColors.kWhite,
                    shape: PinCodeFieldShape.underline,
                    activeColor: AppColors.kPrimary,
                    disabledColor: AppColors.kGrey200,
                    inactiveColor: Colors.transparent,
                    inactiveFillColor: AppColors.kWhite,
                    borderWidth: 1.w,
                    borderRadius: BorderRadius.circular(12.r),
                    errorBorderColor: Colors.red,
                    fieldHeight: 64,
                    fieldWidth: 64,
                    activeFillColor: AppColors.kWhite,
                  ),
                  cursorColor: AppColors.kPrimary,
                  animationDuration: const Duration(milliseconds: 300),
                  controller: pinController,
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
                          .read(loginWithPinViewModel.notifier)
                          .logout()
                          .then((value) => ref
                              .read(loginWithPinViewModel.notifier)
                              .goToLoginView());
                    },
                    child: Text(
                      'Logout',
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
        mainActionButtonText: 'Sign In',
        isLoading: viewState.viewState.isLoading,
        onMainActionButtonTapped: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(loginWithPinViewModel.notifier)
              .loginWithPin(pinCode: pinController.text)
              .then((value) {
            if (value) {
              ref.read(loginWithPinViewModel.notifier).goToDashboardView();
            } else {
              pinController.clear();
              ref.read(loginWithPinViewModel.notifier).showErrorSnackBar();
            }
          });
        },
      ),
    );
  }
}
