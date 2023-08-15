import 'package:citracker/core/widgets/dialog/reusable_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color.dart';
import '../../core/widgets/button/reusable_button.dart';
import '../../core/widgets/dialog/loading_dialog.dart';
import '../../core/widgets/text/application_text.dart';
import '../../services/firebase_auth_service.dart';
import '../../viewmodel/profile/profile_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryElement,
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(20.w),
                    //   bottomRight: Radius.circular(20.w),
                    // ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 100.h,
                    ),
                    child: CircleAvatar(
                      radius: 60.w,
                      backgroundImage: const NetworkImage(
                        "https://i.ibb.co/PGv8ZzG/me.jpg",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Column(
                children: [
                  SizedBox(
                    width: 280.w,
                    child: ApplicationText(
                      text: FirebaseAuthService().getUser()!.displayName!,
                      height: 1.3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ApplicationText(
                    text: FirebaseAuthService().getUser()!.email!,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is LogoutLoading) {
                        loadingDialog(context: context);
                      }
                      if (state is LogoutFailed) {
                        Navigator.pop(context);
                        reusableDialog(context: context, msg: state.message);
                      }
                      if (state is LogoutSuccess) {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'sign_in', (route) => false);
                      }
                    },
                    child: ReusableButton(
                      text: "Logout",
                      onTap: () {
                        context.read<ProfileBloc>().add(LogoutActionEvent());
                      },
                      width: 200,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
