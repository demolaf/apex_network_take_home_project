import 'package:apex_network_take_home_project/src/core/navigation.dart';
import 'package:apex_network_take_home_project/src/services/snackbar_service.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/strings.dart';
import 'package:apex_network_take_home_project/src/ui/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SmartPayApp(),
    ),
  );
}

class SmartPayApp extends ConsumerWidget {
  const SmartPayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: AppStrings.kTitle,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRoute,
          initialRoute: Routes.startupView,
          navigatorKey: ref.read(navigationProvider).navigatorKey,
          scaffoldMessengerKey: ref.read(snackBarProvider).scaffoldMessengerKey,
        );
      },
    );
  }
}
