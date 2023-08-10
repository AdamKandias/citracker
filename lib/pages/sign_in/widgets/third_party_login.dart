import 'package:citracker/pages/sign_in/sign_in_controller.dart';
import 'package:citracker/pages/sign_in/widgets/reusable_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThirdPartyLogin extends StatelessWidget {
  const ThirdPartyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableIcon(
            iconPath: 'assets/icons/google.png',
            onTap: () {
              SignInController(context: context).handleGoogleSignIn();
            },
          ),
          const ReusableIcon(iconPath: 'assets/icons/apple.png'),
          const ReusableIcon(iconPath: 'assets/icons/facebook.png'),
        ],
      ),
    );
  }
}
