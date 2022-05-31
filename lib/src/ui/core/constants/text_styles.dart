import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'component_sizes.dart';
import 'fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static const kHeaderRegular = TextStyle(
    fontFamily: Fonts.kPrimary,
    fontWeight: FontWeight.w700,
    fontSize: FontSize.s18,
  );

  static const kBodyExtraSmall = TextStyle(
    fontFamily: Fonts.kPrimary,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.s8,
  );

  static const kBodySmall = TextStyle(
    fontFamily: Fonts.kPrimary,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.s12,
  );

  static const kBodyMedium = TextStyle(
    fontFamily: Fonts.kPrimary,
    fontWeight: FontWeight.w500,
    fontSize: FontSize.s16,
  );

  static const kBodyBold = TextStyle(
    fontFamily: Fonts.kPrimary,
    fontWeight: FontWeight.w700,
    fontSize: FontSize.s20,
  );

  static const kBodySemiBold = TextStyle(
    fontFamily: Fonts.kPrimary,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.s20,
  );

  static const kBodyRegular = TextStyle(
    fontFamily: Fonts.kPrimary,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.s16,
  );
}
