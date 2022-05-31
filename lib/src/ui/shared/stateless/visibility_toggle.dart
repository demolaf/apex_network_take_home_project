import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';

class CustomVisibilityButton extends StatelessWidget {
  final void Function()? onTap;
  final bool? obscureText;

  const CustomVisibilityButton({
    Key? key,
    required this.onTap,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8.0.w),
        child: Icon(
          obscureText!
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: 24.0.w,
          color: AppColors.kGrey500,
        ),
      ),
    );
  }
}
