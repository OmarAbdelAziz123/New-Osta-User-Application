import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTextStyles{
  static TextStyle regularStyle = TextStyle(
    color: OColors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'CenturyGothicPaneuropean',
    height: 1.4.sp,
  );

  static TextStyle boldStyle = regularStyle.copyWith(
    fontWeight: FontWeight.bold,
  );

  static TextStyle boLd17 = boldStyle.copyWith(
    fontSize: 17.sp,
  );

  static TextStyle boLd16 = boldStyle.copyWith(
    fontSize: 16.sp,
  );

  static TextStyle boLd14= boldStyle.copyWith(
    fontSize: 14.sp,
  );

  static TextStyle regular12= regularStyle.copyWith(
    fontSize: 12.sp,
  );

  static TextStyle bold11= boldStyle.copyWith(
    fontSize: 11.sp,
  );

  static TextStyle bold9= boldStyle.copyWith(
    fontSize: 9.sp,
  );

}