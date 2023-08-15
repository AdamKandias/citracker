import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';

reusableDialog(
    {required BuildContext context,
    required String msg,
    Color backgroundColor = AppColors.primaryElement,
    Color textColor = AppColors.primaryText,
    void Function()? onPressed}) {
  showDialog<void>(
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(
          child: Text('Info'),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  msg,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: SizedBox(
              width: 150.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                ),
                onPressed: onPressed ??
                    () {
                      Navigator.pop(context);
                    },
                child: const Text("OK"),
              ),
            ),
          ),
        ],
      );
    },
    context: context,
    barrierDismissible: true,
  );
}
