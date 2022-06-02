import 'package:apex_network_take_home_project/src/ui/core/constants/image_assets.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/shared/stateless/button.dart';
import 'package:apex_network_take_home_project/src/ui/shared/stateless/circular_loading_indicator.dart';
import 'package:apex_network_take_home_project/src/ui/shared/stateless/gap.dart';
import 'package:apex_network_take_home_project/src/ui/views/main/account_created_success/account_created_success_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/text_styles.dart';

class AccountCreatedSuccessView extends ConsumerStatefulWidget {
  const AccountCreatedSuccessView({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountCreatedSuccessView> createState() =>
      _AccountCreatedSuccessViewState();
}

class _AccountCreatedSuccessViewState
    extends ConsumerState<AccountCreatedSuccessView> {
  @override
  void initState() {
    super.initState();
    ref.read(accountCreatedSuccessViewModel.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(accountCreatedSuccessViewModel);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kWhite,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Insets.xmd.w, vertical: Insets.xlg.h),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.xmd.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageAssets.accountCreatedSuccess,
                    ),
                    Gap.lg,
                    viewState.viewState.isLoading
                        ? const CustomProgressIndicator(
                            color: AppColors.kPrimary,
                          )
                        : RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Congratulations',
                              style: AppTextStyles.kHeaderRegular.copyWith(
                                fontSize: FontSize.s24.sp,
                                color: AppColors.kSecondary,
                              ),
                              children: <TextSpan>[
                                const TextSpan(text: '\n\n'),
                                TextSpan(
                                  text:
                                      'Hey ${ref.watch(accountCreatedSuccessViewModel).fullName?.split(' ')[0].trim()},'
                                      ' your account has been successfully created 👋 ',
                                  style: AppTextStyles.kBodyRegular.copyWith(
                                    fontSize: FontSize.s16.sp,
                                    color: AppColors.kGrey500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                ref
                    .read(accountCreatedSuccessViewModel.notifier)
                    .goToDashboardView();
              },
              color: AppColors.kSecondary,
              height: 52.h,
              child: Text(
                'Proceed to home',
                style: AppTextStyles.kBodyBold.copyWith(
                  fontSize: FontSize.s16.sp,
                  color: AppColors.kWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
