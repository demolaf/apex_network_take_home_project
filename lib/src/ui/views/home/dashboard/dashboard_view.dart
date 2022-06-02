import 'package:apex_network_take_home_project/src/ui/core/constants/colors.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/text_styles.dart';
import 'package:apex_network_take_home_project/src/ui/core/extensions/view_state.dart';
import 'package:apex_network_take_home_project/src/ui/shared/stateless/circular_loading_indicator.dart';
import 'package:apex_network_take_home_project/src/ui/views/home/dashboard/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/component_sizes.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    super.initState();
    ref.read(dashboardViewModel.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(dashboardViewModel);
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kWhite,
        title: Text(
          'Dashboard',
          style: AppTextStyles.kHeaderRegular
              .copyWith(color: AppColors.kSecondary),
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.black),
            child: PopupMenuButton(
              iconSize: 32,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () async {
                      await ref
                          .read(dashboardViewModel.notifier)
                          .signOut()
                          .then((value) => ref
                              .read(dashboardViewModel.notifier)
                              .goToLoginView());
                    },
                    child: const Text(
                      'Sign out',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Insets.xmd.w, vertical: Insets.xlg.h),
        child: Center(
          child: viewState.viewState.isLoading
              ? const CustomProgressIndicator(
                  color: AppColors.kPrimary,
                  radius: 12,
                )
              : Text(
                  ref.watch(dashboardViewModel).secret ?? 'N/A',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.kBodyMedium.copyWith(
                    fontSize: FontSize.s20,
                    color: AppColors.kSecondary,
                  ),
                ),
        ),
      ),
    );
  }
}
