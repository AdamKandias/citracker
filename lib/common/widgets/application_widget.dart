import 'package:citracker/common/constants/color.dart';
import 'package:citracker/pages/home/home.dart';
import 'package:citracker/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget applicationPage(int index) {
  List<Widget> widget = [
    const Home(),
    Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: AppColors.primaryFourthElementText,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Row(
                children: [
                  Container(
                    width: 190.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.w),
                        ),
                        border: Border.all(
                            color: AppColors.primaryThirdElementText)),
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      child: SizedBox(
                        height: 100.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                right: 5.w,
                              ),
                              width: 15.w,
                              height: 15.w,
                              child: Image.asset(
                                "assets/icons/search.png",
                              ),
                            ),
                            SizedBox(
                              width: 150.w,
                              child: TextFormField(
                                cursorColor: AppColors.primaryElement,
                                style: TextStyle(
                                  color: AppColors.primaryElement,
                                  fontSize: 13.sp,
                                ),
                                autocorrect: false,
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Cari di Citracker",
                                    hintStyle: TextStyle(
                                        color: AppColors.primaryElement,
                                        fontSize: 13.sp)),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Icon(
                    Icons.mail_outline,
                    color: AppColors.primarySecondaryElementText,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        color: AppColors.primarySecondaryElementText,
                      ),
                      Transform.translate(
                        offset: const Offset(12, -5),
                        child: Container(
                          height: 15.w,
                          width: 15.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryElement,
                          ),
                          child: const Center(
                            child: Text(
                              overflow: TextOverflow.fade,
                              "1",
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.primarySecondaryElementText,
                      ),
                      Transform.translate(
                        offset: const Offset(12, -5),
                        child: Container(
                          height: 15.w,
                          width: 15.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryElement,
                          ),
                          child: const Center(
                            child: Text(
                              "9",
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Icon(
                    Icons.menu,
                    color: AppColors.primarySecondaryElementText,
                  ),
                ],
              ),
            ),
          )),
    ),
    const Center(
      child: Text('Analytics'),
    ),
    const Center(
      child: Text('Chat'),
    ),
    const Profile()
  ];

  return widget[index];
}
