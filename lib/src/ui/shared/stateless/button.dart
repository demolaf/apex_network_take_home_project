import 'package:apex_network_take_home_project/src/ui/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../core/constants/component_sizes.dart';
import 'circular_loading_indicator.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final void Function() onPressed;
  final Color? color;
  final Widget child;
  final double? width;
  final double? height;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;

  const CustomButton(
      {Key? key,
      this.isLoading = false,
      required this.onPressed,
      this.width,
      this.height,
      this.color,
      this.elevation = 0,
      this.borderRadius,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: color,
      elevation: elevation,
      constraints: BoxConstraints.tightFor(
        height: height ?? 44,
        width: width ?? double.infinity,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        side: BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Insets.sm,
        horizontal: Insets.md,
      ),
      child: isLoading
          ? const CustomProgressIndicator(
              color: AppColors.kGrey200,
            )
          : FittedBox(child: child),
    );
  }
}
