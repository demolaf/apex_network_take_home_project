import 'package:apex_network_take_home_project/src/ui/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? radius;

  const CustomProgressIndicator({Key? key, this.color, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SizedBox(
        height: 16,
        width: 16,
        child: CupertinoActivityIndicator(
          color: color ?? AppColors.kGrey500,
          radius: radius?.r ?? 10,
        ),
      );
    } else {
      return SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          color: color ?? Colors.white,
          strokeWidth: 3.0,
        ),
      );
    }
  }
}
