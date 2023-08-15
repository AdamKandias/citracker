import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';

PreferredSizeWidget reusableAppBar(String text) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.h),
      child: Container(
        color: AppColors.primarySecondaryBackground,
        height: 1.0,
      ),
    ),
    title: Text(
      text,
      style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal),
    ),
  );
}
