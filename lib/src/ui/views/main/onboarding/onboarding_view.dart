import 'package:apex_network_take_home_project/src/ui/shared/stateless/gap.dart';
import 'package:apex_network_take_home_project/src/ui/views/main/onboarding/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/component_sizes.dart';
import '../../../core/constants/image_assets.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/stateless/button.dart';

class OnBoardingView extends ConsumerWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(onBoardingViewModel).goToLoginView();
                  },
                  child: Text(
                    'Skip',
                    style: AppTextStyles.kBodyBold.copyWith(
                      color: AppColors.kPrimary400,
                      fontSize: FontSize.s16.sp,
                    ),
                  ),
                )
              ],
            ),
            const Gap(18),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: IntroductionScreen(
                      globalBackgroundColor: AppColors.kWhite,
                      controlsPadding: EdgeInsets.only(bottom: 72.h),
                      dotsDecorator: DotsDecorator(
                        color: AppColors.kGrey200,
                        activeColor: AppColors.kSecondary,
                        activeSize: Size(36.0.w, 8.0.h),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Insets.md.r),
                        ),
                      ),
                      pages: [
                        PageViewModel(
                          image: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                bottom: -100.h,
                                child: SizedBox(
                                  width: 220.w,
                                  child: Image.asset(
                                    ImageAssets.onBoardingView1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          bodyWidget: Text(
                            'Your finance work starts here. Our here to help you'
                            ' track and deal with speeding up your transactions.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.kBodyRegular.copyWith(
                              fontSize: FontSize.s16.sp,
                              color: AppColors.kGrey500,
                            ),
                          ),
                          titleWidget: Text(
                            'Finance app the safest and most trusted',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.kHeaderRegular.copyWith(
                              fontSize: FontSize.s24.sp,
                              color: AppColors.kSecondary,
                            ),
                          ),
                        ),
                        PageViewModel(
                          image: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                bottom: -110.h,
                                child: SizedBox(
                                  width: 220.w,
                                  child: Image.asset(
                                    ImageAssets.onBoardingView2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          bodyWidget: Text(
                            'Get easy to pay all your bills with just a few steps. '
                            'Paying your bills become fast and efficient.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.kBodyRegular.copyWith(
                              fontSize: FontSize.s16.sp,
                              color: AppColors.kGrey500,
                            ),
                          ),
                          titleWidget: Text(
                            'The fastest transaction process only here',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.kHeaderRegular.copyWith(
                              fontSize: FontSize.s22.sp,
                              color: AppColors.kSecondary,
                            ),
                          ),
                        ),
                      ],
                      showDoneButton: false,
                      showNextButton: false,
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      ref.read(onBoardingViewModel).goToLoginView();
                    },
                    color: AppColors.kSecondary,
                    height: 52.h,
                    child: Text(
                      'Get Started',
                      style: AppTextStyles.kBodyBold.copyWith(
                        fontSize: FontSize.s16.sp,
                        color: AppColors.kWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
