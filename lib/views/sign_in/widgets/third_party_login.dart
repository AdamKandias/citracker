import 'package:citracker/viewmodel/sign_in/sign_in_event.dart';
import 'package:citracker/views/sign_in/widgets/reusable_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/dialog/loading_dialog.dart';
import '../../../core/widgets/dialog/reusable_dialog.dart';
import '../../../viewmodel/sign_in/sign_in_bloc.dart';
import '../../../viewmodel/sign_in/sign_in_state.dart';

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
          BlocListener<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state is GoogleSignInLoading) {
                loadingDialog(context: context);
              }
              if (state is GoogleSignInFailed) {
                Navigator.pop(context);
                reusableDialog(context: context, msg: state.message);
              }
              if (state is GoogleSignInCancel) {
                Navigator.pop(context);
              }
              if (state is GoogleSignInSuccess) {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, 'application', (route) => false);
              }
            },
            child: ReusableIcon(
              iconPath: 'assets/icons/google.png',
              onTap: () {
                context.read<SignInBloc>().add(GoogleLoginActionEvent());
              },
            ),
          ),
          const ReusableIcon(iconPath: 'assets/icons/apple.png'),
          const ReusableIcon(iconPath: 'assets/icons/facebook.png'),
        ],
      ),
    );
  }
}
