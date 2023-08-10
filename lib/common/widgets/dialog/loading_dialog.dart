import 'package:citracker/common/constants/color.dart';
import 'package:flutter/material.dart';

loadingDialog({required BuildContext context}) {
  showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryElement,
          ),
        );
      });
}
