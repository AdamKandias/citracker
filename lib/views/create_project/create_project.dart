import 'package:citracker/core/widgets/dialog/reusable_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color.dart';
import '../../core/widgets/appbar/sign_in_appbar.dart';
import '../../core/widgets/button/reusable_button.dart';
import '../../core/widgets/datepicker/reusable_datepicker.dart';
import '../../core/widgets/dialog/loading_dialog.dart';
import '../../core/widgets/text/reusable_text.dart';
import '../../core/widgets/textfield/reusable_text_field.dart';
import '../../viewmodel/home/home_bloc.dart';
import '../../viewmodel/project/create_project/create_project_bloc.dart';
import '../../viewmodel/project/create_project/create_project_event.dart';
import '../../viewmodel/project/create_project/create_project_state.dart';

class CreateProject extends StatelessWidget {
  const CreateProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: reusableAppBar("Add New Project"),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 10.w),
            child: Column(
              children: [
                const ReusableText(
                    text: "Enter the project information in form below"),
                Container(
                  margin: EdgeInsets.only(top: 50.h),
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ReusableText(
                        text: "Project Title",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ReusableTextField(
                        iconPath: "assets/icons/file-text.png",
                        hintText: "Enter the project title",
                        iconColor: AppColors.primaryText,
                        onChanged: (value) {
                          context
                              .read<CreateProjectBloc>()
                              .add(TitleChangedEvent(title: value));
                        },
                      ),
                      const ReusableText(
                        text: "Description",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ReusableTextField(
                        textInputType: TextInputType.emailAddress,
                        iconPath: "assets/icons/profile_book.png",
                        iconColor: AppColors.primaryText,
                        hintText: "Enter the project description",
                        onChanged: (value) {
                          context
                              .read<CreateProjectBloc>()
                              .add(DescriptionChangedEvent(description: value));
                        },
                      ),
                      const ReusableText(
                        text: "Due Date",
                      ),
                      ReusableDatePicker(
                        onChanged: (date) {
                          context
                              .read<CreateProjectBloc>()
                              .add(DueDateChangedEvent(dueDate: date));
                        },
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      BlocListener<CreateProjectBloc, CreateProjectState>(
                        listener: (context, state) {
                          if (state is CreateProjectLoading) {
                            loadingDialog(context: context);
                          }
                          if (state is CreateProjectFailed) {
                            Navigator.pop(context);
                            reusableDialog(
                                context: context, msg: state.message);
                          }
                          if (state is CreateProjectSuccess) {
                            Navigator.pop(context);
                            reusableDialog(
                              context: context,
                              msg: state.message,
                              backgroundColor: Colors.green,
                              onPressed: () {
                                context.read<HomeBloc>().add(ProjectLoad());
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "application",
                                  (route) => false,
                                );
                              },
                            );
                          }
                        },
                        child: ReusableButton(
                            text: "Add New Project",
                            onTap: () {
                              context
                                  .read<CreateProjectBloc>()
                                  .add(CreateProjectActionEvent());
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
