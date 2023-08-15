import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final String iconPath;
  final Color? iconColor;
  final TextInputType? textInputType;
  final bool? obsecureText;
  final Function? onChanged;
  final String? initialValue;

  const ReusableTextField(
      {super.key,
      required this.hintText,
      required this.iconPath,
      this.textInputType = TextInputType.text,
      this.obsecureText = false,
      this.onChanged,
      this.iconColor,
      this.initialValue});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          border: Border.all(color: AppColors.primaryFourthElementText)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 17.w),
            width: 16.w,
            height: 16.w,
            child: Image.asset(
              iconPath,
              color: iconColor,
            ),
          ),
          SizedBox(
            width: 255.w,
            height: 50.h,
            child: initialValue != null
                ? TextFormField(
                    initialValue: initialValue,
                    autocorrect: false,
                    keyboardType: textInputType,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: const TextStyle(
                            color: AppColors.primarySecondaryElementText),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none)),
                    onChanged: (value) => onChanged!(value),
                    obscureText: obsecureText!,
                  )
                : TextField(
                    autocorrect: false,
                    keyboardType: textInputType,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: const TextStyle(
                            color: AppColors.primarySecondaryElementText),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none)),
                    onChanged: (value) => onChanged!(value),
                    obscureText: obsecureText!,
                  ),
          )
        ],
      ),
    );
  }
}
