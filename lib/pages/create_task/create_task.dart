import 'package:citracker/common/widgets/appbar/sign_in_appbar.dart';
import 'package:citracker/common/widgets/button/reusable_button.dart';
import 'package:citracker/common/widgets/text/reusable_text.dart';
import 'package:citracker/common/widgets/textfield/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: reusableAppBar("Add New Task"),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            child: Column(
              children: [
                const ReusableText(
                    text: "Enter your information in form below"),
                Container(
                  margin: EdgeInsets.only(top: 40.h),
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ReusableText(
                        text: "Username",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const ReusableTextField(
                        iconPath: "assets/icons/user.png",
                        hintText: "Enter your username",
                      ),
                      const ReusableText(
                        text: "Email",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const ReusableTextField(
                        textInputType: TextInputType.emailAddress,
                        iconPath: "assets/icons/user.png",
                        hintText: "Enter your email address",
                      ),
                      const ReusableText(
                        text: "Password",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const ReusableTextField(
                        obsecureText: true,
                        textInputType: TextInputType.text,
                        iconPath: "assets/icons/lock.png",
                        hintText: "Enter password",
                      ),
                      const ReusableText(
                        text: "Password Confirm",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const ReusableTextField(
                        obsecureText: true,
                        textInputType: TextInputType.text,
                        iconPath: "assets/icons/lock.png",
                        hintText: "Re-Enter your password",
                      ),
                      const ReusableText(
                        text:
                            "By creating an account you have to agree\nwith our term & condition",
                        fontSize: 12,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      ReusableButton(
                          text: "Register",
                          onTap: () {
                            // RegisterController(context: context)
                            //     .handleRegister();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
