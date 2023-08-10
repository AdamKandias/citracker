import 'package:citracker/common/widgets/appbar/sign_in_appbar.dart';
import 'package:citracker/common/widgets/button/reusable_button.dart';
import 'package:citracker/common/widgets/dialog/loading_dialog.dart';
import 'package:citracker/common/widgets/text/reusable_text.dart';
import 'package:citracker/common/widgets/textfield/reusable_text_field.dart';
import 'package:citracker/pages/sign_in/bloc/sign_in_event.dart';
import 'package:citracker/pages/sign_in/sign_in_controller.dart';
import 'package:citracker/pages/sign_in/widgets/forgot_password.dart';
import 'package:citracker/pages/sign_in/widgets/third_party_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/sign_in_bloc.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: reusableAppBar("Login Page"),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
            child: Column(
              children: [
                const ThirdPartyLogin(),
                const ReusableText(text: "Or use your email account to login"),
                Container(
                  margin: EdgeInsets.only(top: 70.h),
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            .read<SignInBloc>()
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
                            .read<SignInBloc>()
                            .add(PasswordEvent(password: value)),
                      ),
                      const ForgotPassword(),
                      SizedBox(
                        height: 70.h,
                      ),
                      ReusableButton(
                          text: "Login",
                          onTap: () {
                            loadingDialog(context: context);
                            SignInController(context: context).handleSignIn();
                          }),
                      SizedBox(
                        height: 10.h,
                      ),
                      ReusableButton(
                        text: "Register",
                        outlineButton: true,
                        onTap: () {
                          Navigator.pushNamed(context, 'register');
                        },
                      ),
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
