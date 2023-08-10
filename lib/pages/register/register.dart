import 'package:citracker/common/widgets/appbar/sign_in_appbar.dart';
import 'package:citracker/common/widgets/button/reusable_button.dart';
import 'package:citracker/common/widgets/dialog/loading_dialog.dart';
import 'package:citracker/common/widgets/text/reusable_text.dart';
import 'package:citracker/common/widgets/textfield/reusable_text_field.dart';
import 'package:citracker/pages/register/bloc/register_event.dart';
import 'package:citracker/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/register_bloc.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: reusableAppBar("Register Page"),
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
                      ReusableTextField(
                          iconPath: "assets/icons/user.png",
                          hintText: "Enter your username",
                          onChanged: (value) => context
                              .read<RegisterBloc>()
                              .add(UsernameEvent(username: value))),
                      const ReusableText(
                        text: "Email",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ReusableTextField(
                        textInputType: TextInputType.emailAddress,
                        iconPath: "assets/icons/user.png",
                        hintText: "Enter your email address",
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(EmailEvent(email: value)),
                      ),
                      const ReusableText(
                        text: "Password",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ReusableTextField(
                        obsecureText: true,
                        textInputType: TextInputType.text,
                        iconPath: "assets/icons/lock.png",
                        hintText: "Enter password",
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(PasswordEvent(password: value)),
                      ),
                      const ReusableText(
                        text: "Password Confirm",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ReusableTextField(
                        obsecureText: true,
                        textInputType: TextInputType.text,
                        iconPath: "assets/icons/lock.png",
                        hintText: "Re-Enter your password",
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(PasswordConfirmEvent(passwordConfirm: value)),
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
                            loadingDialog(context: context);
                            RegisterController(context: context)
                                .handleRegister();
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
