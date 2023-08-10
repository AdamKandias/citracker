import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableIcon extends StatelessWidget {
  final String iconPath;
  final Function()? onTap;

  const ReusableIcon({super.key, required this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 40.w,
        height: 40.w,
        child: Image.asset(
          iconPath,
        ),
      ),
    );
  }
}
