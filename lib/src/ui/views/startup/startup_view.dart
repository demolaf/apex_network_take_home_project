import 'package:apex_network_take_home_project/src/ui/core/constants/image_assets.dart';
import 'package:apex_network_take_home_project/src/ui/views/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/constants/colors.dart';
import '../../shared/stateless/circular_loading_indicator.dart';
import '../../shared/stateless/gap.dart';

class StartupView extends ConsumerStatefulWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  ConsumerState<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends ConsumerState<StartupView> {
  @override
  void initState() {
    super.initState();
    ref.read(startupViewModel).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.kWhite,
      body: StartupViewBody(),
    );
  }
}

class StartupViewBody extends StatelessWidget {
  const StartupViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageAssets.splashLogo,
            width: 200.w,
          ),
          const Gap(64),
          CustomProgressIndicator(
            color: AppColors.kGrey500,
            radius: 16.r,
          ),
        ],
      ),
    );
  }
}
