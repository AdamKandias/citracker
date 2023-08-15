import 'package:citracker/core/widgets/dialog/loading_dialog.dart';
import 'package:citracker/core/widgets/dialog/reusable_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/appbar/sign_in_appbar.dart';
import '../../core/widgets/button/reusable_button.dart';
import '../../core/widgets/text/reusable_text.dart';
import '../../core/widgets/textfield/reusable_text_field.dart';
import '../../viewmodel/register/register_bloc.dart';
import '../../viewmodel/register/register_event.dart';
import '../../viewmodel/register/register_state.dart';

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
                      BlocListener<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterLoading) {
                            loadingDialog(context: context);
                          }
                          if (state is RegisterFailed) {
                            Navigator.pop(context);
                            reusableDialog(
                                context: context, msg: state.message);
                          }
                          if (state is RegisterSuccess) {
                            Navigator.pop(context);
                            reusableDialog(
                              context: context,
                              msg: state.message,
                              backgroundColor: Colors.green,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );
                            // Navigator.pop(context);
                          }
                        },
                        child: ReusableButton(
                            text: "Register",
                            onTap: () {
                              context
                                  .read<RegisterBloc>()
                                  .add(RegisterActionEvent());
                            }),
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
