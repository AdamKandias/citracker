import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems() {
  return [
    BottomNavigationBarItem(
      label: 'Home',
      icon: SizedBox(
        width: 15.w,
        height: 15.w,
        child: Image.asset(
          "assets/icons/home.png",
          fit: BoxFit.fill,
        ),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.w,
        child: Image.asset(
          "assets/icons/home.png",
          color: AppColors.primaryElement,
          fit: BoxFit.fill,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Search',
      icon: SizedBox(
        width: 15.w,
        height: 15.w,
        child: Image.asset(
          "assets/icons/search2.png",
          fit: BoxFit.fill,
        ),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.w,
        child: Image.asset(
          "assets/icons/search2.png",
          color: AppColors.primaryElement,
          width: 120.0,
          height: 120.0,
          fit: BoxFit.fill,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Course',
      icon: SizedBox(
        width: 15.w,
        height: 15.w,
        child: Image.asset(
          "assets/icons/play-circle1.png",
          fit: BoxFit.fill,
        ),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.w,
        child: Image.asset(
          "assets/icons/play-circle1.png",
          color: AppColors.primaryElement,
          fit: BoxFit.fill,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Chat',
      icon: SizedBox(
        width: 15.w,
        height: 15.w,
        child: Image.asset(
          "assets/icons/message-circle.png",
          fit: BoxFit.fill,
        ),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.w,
        child: Image.asset(
          "assets/icons/message-circle.png",
          color: AppColors.primaryElement,
          fit: BoxFit.fill,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Profile',
      icon: SizedBox(
        width: 15.w,
        height: 15.w,
        child: Image.asset(
          "assets/icons/person2.png",
          fit: BoxFit.fill,
        ),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.w,
        child: Image.asset(
          "assets/icons/person2.png",
          color: AppColors.primaryElement,
          fit: BoxFit.fill,
        ),
      ),
    ),
  ];
}
