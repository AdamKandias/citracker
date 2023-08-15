import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/color.dart';
import '../../core/constants/storage.dart';
import '../../global.dart';
import '../../viewmodel/welcome/welcome_bloc.dart';
import '../../viewmodel/welcome/welcome_event.dart';
import '../../viewmodel/welcome/welcome_state.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SizedBox(
          width: 375.w,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (value) {
                  context
                      .read<WelcomeBloc>()
                      .add(PageChangedEvent(page: value));
                },
                children: [
                  _page(
                    1,
                    context,
                    "NEXT",
                    "Managing Your Task Easily",
                    "Effortlessly Organize, Prioritize, and Excel in Every Task",
                    "assets/images/process.svg",
                  ),
                  _page(
                    2,
                    context,
                    "NEXT",
                    "Achieve More as One",
                    "Building Bridges, Fostering Communication, and Achieving Together",
                    "assets/images/team_up.svg",
                  ),
                  _page(
                      3,
                      context,
                      "GET STARTED",
                      "Analyst Project Journey",
                      "Monitoring Progress and Steering Your Project's Path Forward",
                      "assets/images/projections.svg"),
                ],
              ),
              Positioned(
                bottom: 65.h,
                child: BlocBuilder<WelcomeBloc, WelcomeState>(
                  builder: (context, state) {
                    return DotsIndicator(
                      position: state.page,
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          activeColor: AppColors.primaryElement,
                          color: AppColors.primaryThirdElementText,
                          size: const Size.square(8.0),
                          activeSize: const Size(18.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subtitle, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          width: 345.w,
          height: 290.h,
          child: SvgPicture.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 24.sp,
              fontWeight: FontWeight.normal),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primarySecondaryElementText,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        InkWell(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            } else {
              Global.storageService.setBool(
                  StorageConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
              Navigator.pushNamedAndRemoveUntil(
                context,
                'sign_in',
                (route) => false,
              );
            }
          },
          child: Container(
            width: 325.w,
            height: 40.h,
            margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
            decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, -1)),
                ]),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
