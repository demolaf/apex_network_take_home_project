import 'package:apex_network_take_home_project/src/ui/core/constants/colors.dart';
import 'package:apex_network_take_home_project/src/ui/core/constants/component_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/text_styles.dart';
import 'gap.dart';

/// Reusable TextField for forms
class CustomTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? isDense;
  final void Function()? onTap;
  final TextInputType? keyBoardType;
  final TextEditingController? controller;
  final EdgeInsets? contentPadding;
  final String? hintText;
  final String? bottomText;
  final TextStyle? textStyle;
  final double? maxWidth;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool hasBorder;
  final Color textFieldColor;
  final String? counterText;
  final void Function(String input)? onChanged;
  final String? Function(String? input)? validator;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;

  const CustomTextField({
    Key? key,
    this.obscureText,
    this.enabled,
    this.controller,
    this.keyBoardType,
    this.prefixIcon,
    this.hintText,
    this.maxLines,
    this.maxLength,
    this.minLines,
    this.suffixIcon,
    this.focusNode,
    this.bottomText,
    this.textStyle,
    this.hasBorder = true,
    this.textFieldColor = AppColors.kWhite,
    this.onChanged,
    this.counterText,
    this.validator,
    this.isDense = false,
    this.contentPadding,
    this.onTap,
    this.maxWidth,
    this.inputFormatters,
    this.textInputAction,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onTap: onTap,
          obscureText: obscureText == null ? false : obscureText!,
          maxLines: maxLines ?? 1,
          minLines: minLines,
          cursorColor: AppColors.kSecondary,
          style: textStyle ??
              AppTextStyles.kBodyRegular.copyWith(fontSize: FontSize.s16.sp),
          keyboardType: keyBoardType,
          maxLength: maxLength,
          cursorWidth: 1.w,
          controller: controller,
          enabled: enabled,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onEditingComplete: onEditingComplete,
          inputFormatters: inputFormatters,
          obscuringCharacter: '●',
          decoration: InputDecoration(
            filled: true,
            errorMaxLines: 4,
            fillColor: textFieldColor,
            hintText: hintText,
            constraints: maxWidth != null
                ? BoxConstraints(
                    maxWidth: maxWidth?.w ?? 50.w,
                  )
                : null,
            hintStyle: AppTextStyles.kBodyMedium
                .copyWith(color: AppColors.kGrey400, fontSize: FontSize.s16.sp),
            isDense: isDense,
            counterText: counterText ?? '',
            prefixIcon: prefixIcon,
            border: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Insets.md.r),
                    ),
                    borderSide: BorderSide.none,
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
            focusedBorder: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Insets.md.r),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.kPrimary,
                      width: 1.0.w,
                    ),
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
            enabledBorder: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Insets.md.r),
                    ),
                    borderSide: BorderSide.none,
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: Insets.md.w, vertical: Insets.md.h),
            suffixIcon: suffixIcon,
          ),
        ),
        if (bottomText != null) ...[
          Gap.md,
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: bottomText != null
                  ? Text(
                      bottomText!,
                      style: AppTextStyles.kBodyExtraSmall,
                    )
                  : null,
            ),
          ),
        ],
      ],
    );
  }
}
