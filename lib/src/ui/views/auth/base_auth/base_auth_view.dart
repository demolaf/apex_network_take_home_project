import 'package:apex_network_take_home_project/src/ui/core/constants/colors.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/component_sizes.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/svg_assets.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/text_styles.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/shared/stateless/button.dart';
import 'package:apex_network_take_home_project/src/ui/views/auth/base_auth/base_auth_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/stateless/gap.dart';

class BaseAuthenticationView extends ConsumerWidget {
  final Form form;
  final Widget? headerText;
  final bool canGoBack;
  final bool hasFooterText;
  final bool hasSocialAuth;
  final String mainActionButtonText;
  final String? footerTextLeading;
  final String? footerTextTrailing;
  final bool isLoading;
  final void Function() onMainActionButtonTapped;
  final void Function()? onFooterActionTapped;

  const BaseAuthenticationView({
    Key? key,
    required this.form,
    this.headerText,
    this.canGoBack = false,
    required this.mainActionButtonText,
    this.hasFooterText = false,
    this.footerTextLeading,
    this.footerTextTrailing,
    this.onFooterActionTapped,
    this.hasSocialAuth = true,
    this.isLoading = false,
    required this.onMainActionButtonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(baseAuthViewModel);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Insets.xmd.w, vertical: Insets.xlg.h),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                canGoBack
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ref.read(baseAuthViewModel.notifier).goBack();
                            },
                            child: Container(
                              padding: EdgeInsets.all(Insets.xsm.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Insets.xsm.r),
                                ),
                                border: Border.all(
                                  color: AppColors.kGrey200,
                                  width: 1.w,
                                ),
                              ),
                              child: Icon(
                                Icons.adaptive.arrow_back_rounded,
                                color: AppColors.kSecondary,
                                size: IconSize.sm.w,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Gap.lg,
                Gap.lg,
                // HEADER TEXT
                headerText!,
                Gap.lg,
                // FORM
                SingleChildScrollView(
                  child: form,
                ),
                Gap.lg,
                CustomButton(
                  onPressed: onMainActionButtonTapped,
                  color: AppColors.kSecondary,
                  height: 52.h,
                  isLoading:
                      !isLoading ? viewState.viewState.isLoading : isLoading,
                  child: Text(
                    mainActionButtonText,
                    style: AppTextStyles.kBodyBold.copyWith(
                      fontSize: FontSize.s16.sp,
                      color: AppColors.kWhite,
                    ),
                  ),
                ),
                const Gap(32),
                if (hasSocialAuth) ...[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 1.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.kGrey200,
                                AppColors.kWhite,
                              ],
                              stops: [0.25, 0.9],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Insets.xsm.w),
                        child: Text(
                          'OR',
                          style: AppTextStyles.kBodyRegular.copyWith(
                            color: AppColors.kGrey500,
                            fontSize: FontSize.s14.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.kGrey200,
                                AppColors.kWhite,
                              ],
                              stops: [0.25, 0.9],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await ref
                                .read(baseAuthViewModel.notifier)
                                .loginWithGoogle();
                          },
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: Container(
                            height: 52.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: Insets.md.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              border: Border.all(
                                color: AppColors.kGrey200,
                                width: 1.w,
                              ),
                            ),
                            child: Center(
                              child: FittedBox(
                                child: SvgPicture.asset(
                                  SvgAssets.googleIcon,
                                  width: FontSize.s24.w,
                                  height: FontSize.s24.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap.md,
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await ref
                                .read(baseAuthViewModel.notifier)
                                .loginWithApple();
                          },
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: Container(
                            height: 52.h,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              border: Border.all(
                                color: AppColors.kGrey200,
                                width: 1.w,
                              ),
                            ),
                            child: Center(
                              child: FittedBox(
                                child: SvgPicture.asset(
                                  SvgAssets.appleIcon,
                                  width: FontSize.s24.w,
                                  height: FontSize.s24.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (hasFooterText)
            RichText(
              text: TextSpan(
                text: footerTextLeading,
                style: AppTextStyles.kBodyRegular.copyWith(
                  fontSize: FontSize.s16.sp,
                  color: AppColors.kGrey500,
                ),
                children: <TextSpan>[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: footerTextTrailing,
                    recognizer: TapGestureRecognizer()
                      ..onTap = onFooterActionTapped,
                    style: AppTextStyles.kBodyBold.copyWith(
                      fontSize: FontSize.s16.sp,
                      color: AppColors.kPrimary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
