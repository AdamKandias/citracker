import 'package:citracker/common/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationText extends StatelessWidget {
  final String text;
  final bool textTrucate;
  final double height;
  final Color color;
  final FontWeight fontWeight;
  final int fontSize;
  final int marginTop;
  final TextAlign textAlign;
  const ApplicationText(
      {super.key,
      required this.text,
      this.color = AppColors.primaryText,
      this.marginTop = 0,
      this.fontSize = 20,
      this.fontWeight = FontWeight.bold,
      this.height = 1,
      this.textTrucate = false,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop.h),
      child: Text(
        text,
        textAlign: textAlign,
        overflow: textTrucate ? TextOverflow.ellipsis : TextOverflow.visible,
        style: TextStyle(
          height: height.sp,
          fontSize: fontSize.sp,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
