import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/appbar/sign_in_appbar.dart';
import '../../core/widgets/button/reusable_button.dart';
import '../../core/widgets/dialog/loading_dialog.dart';
import '../../core/widgets/dialog/reusable_dialog.dart';
import '../../core/widgets/text/reusable_text.dart';
import '../../core/widgets/textfield/reusable_text_field.dart';
import '../../viewmodel/sign_in/sign_in_bloc.dart';
import '../../viewmodel/sign_in/sign_in_event.dart';
import '../../viewmodel/sign_in/sign_in_state.dart';
import 'widgets/forgot_password.dart';
import 'widgets/third_party_login.dart';

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
                      BlocListener<SignInBloc, SignInState>(
                        listener: (context, state) {
                          if (state is SignInLoading) {
                            loadingDialog(context: context);
                          }
                          if (state is SignInFailed) {
                            Navigator.pop(context);
                            reusableDialog(
                                context: context, msg: state.message);
                          }
                          if (state is SignInSuccess) {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'application', (route) => false);
                          }
                        },
                        child: ReusableButton(
                            text: "Login",
                            onTap: () {
                              context
                                  .read<SignInBloc>()
                                  .add(LoginActionEvent());
                            }),
                      ),
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
