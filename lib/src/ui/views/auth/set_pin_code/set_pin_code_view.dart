import 'package:apex_network_take_home_project/src/repository/user/user_impl.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/validation_extension.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/set_pin_code/set_pin_code_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/text_styles.dart';
import '../base_auth/base_auth_view.dart';

class SetPinCodeView extends HookConsumerWidget {
  SetPinCodeView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(setPinCodeViewModel);
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
        canGoBack: true,
        hasSocialAuth: false,
        headerText: RichText(
          text: TextSpan(
            text: 'Set your PIN code',
            style: AppTextStyles.kHeaderRegular.copyWith(
              fontSize: FontSize.s24.sp,
              color: AppColors.kSecondary,
            ),
            children: <TextSpan>[
              const TextSpan(text: '\n\n'),
              TextSpan(
                text:
                    'We use state-of-the-art security measures to protect your information at all times',
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
            child: SingleChildScrollView(
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
                    validator: context.validatePinCode,
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
                ],
              ),
            ),
          ),
        ),
        mainActionButtonText: 'Create PIN',
        isLoading: viewState.viewState.isLoading,
        onMainActionButtonTapped: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(setPinCodeViewModel.notifier)
              .setAndSaveUserPinCode(pinCode: pinController.text)
              .then((value) => ref
                  .read(setPinCodeViewModel.notifier)
                  .checkIfRegisterFlowThenNavigate());
        },
      ),
    );
  }
}
