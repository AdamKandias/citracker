import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 260.w,
            decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.h),
                    bottomLeft: Radius.circular(20.h)),
                border: Border.all(color: AppColors.primaryFourthElementText)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 17.w),
                  width: 18.w,
                  height: 18.w,
                  child: Image.asset(
                    "assets/icons/search.png",
                  ),
                ),
                SizedBox(
                  width: 200.w,
                  child: TextField(
                    cursorColor: AppColors.primaryElement,
                    autocorrect: false,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        hintText: "Search the project name",
                        hintStyle: const TextStyle(
                            color: AppColors.primarySecondaryElementText),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none)),
                    // onChanged: (value) => onChanged!(value),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 40.h,
              width: 60.w,
              decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(13.w),
                      bottomRight: Radius.circular(13.w)),
                  border: Border.all(color: AppColors.primaryElement)),
              child: Image.asset(
                "assets/icons/search.png",
                color: AppColors.primaryBackground,
                scale: 1.3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
