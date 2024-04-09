import '../../../utils/constants/exports.dart';

class AppBoxShadows {
  /// Button Shadows
  /// Button Shadow One
  static final BoxShadow buttonShadowOne = BoxShadow(
    color: OColors.primaryColor500.withOpacity(.25),
    spreadRadius: 0,
    blurRadius: 24.r,
    offset: Offset(4.w, 8.h),
  );
  /// Button Shadow Two
  static final BoxShadow buttonShadowTwo = BoxShadow(
    color: OColors.primaryColor500.withOpacity(.20),
    spreadRadius: 0,
    blurRadius: 32.r,
    offset: Offset(4.w, 12.h),
  );
  /// Button Shadow Three
  static final BoxShadow buttonShadowThree = BoxShadow(
    color: OColors.primaryColor500.withOpacity(.20),
    spreadRadius: 0,
    blurRadius: 32.r,
    offset: Offset(4.w, 16.h),
  );

  /// Button Shadows
  /// Card Shadow One
  static final BoxShadow cardShadowOne = BoxShadow(
    color: OColors.cardShadowOne.withOpacity(.08),
    spreadRadius: 0,
    blurRadius: 60.r,
    offset: Offset(0.w, 4.h),
  );
  /// Card Shadow Two
  static final BoxShadow cardShadowTwo = BoxShadow(
    color: OColors.cardShadowTwo.withOpacity(.05),
    spreadRadius: 0,
    blurRadius: 60.r,
    offset: Offset(0.w, 4.h),
  );
  /// Card Shadow Three
  static final BoxShadow cardShadowThree = BoxShadow(
    color: OColors.cardShadowThree.withOpacity(.08),
    spreadRadius: 0,
    blurRadius: 100.r,
    offset: Offset(0.w, 20.h),
  );
  /// Card Shadow Four
  static final BoxShadow cardShadowFour = BoxShadow(
    color: OColors.blackColor.withOpacity(.1),
    spreadRadius: 0,
    blurRadius: 10.r,
    offset: Offset(0.w, 4.h),
  );
}