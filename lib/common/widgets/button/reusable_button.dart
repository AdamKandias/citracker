import 'package:citracker/common/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final int height;
  final int width;
  final int fontSize;
  final FontWeight fontWeight;
  final bool outlineButton;
  final Function onTap;
  const ReusableButton(
      {super.key,
      required this.text,
      this.outlineButton = false,
      required this.onTap,
      this.height = 50,
      this.width = 325,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal,
      this.backgroundColor = AppColors.primaryElement});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
            color:
                outlineButton ? AppColors.primaryBackground : backgroundColor,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(
              color: outlineButton
                  ? AppColors.primaryFourthElementText
                  : Colors.transparent,
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
                color: Colors.grey.withOpacity(0.1),
              )
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize.sp,
              fontWeight: fontWeight,
              color: outlineButton
                  ? AppColors.primaryText
                  : AppColors.primaryBackground,
            ),
          ),
        ),
      ),
    );
  }
}
