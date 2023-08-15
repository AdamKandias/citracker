import 'package:citracker/core/constants/color.dart';
import 'package:citracker/core/widgets/dialog/loading_dialog.dart';
import 'package:citracker/core/widgets/dialog/reusable_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/widgets/appbar/sign_in_appbar.dart';
import '../../core/widgets/button/reusable_button.dart';
import '../../core/widgets/datepicker/reusable_datepicker.dart';
import '../../core/widgets/text/reusable_text.dart';
import '../../core/widgets/textfield/reusable_text_field.dart';
import '../../viewmodel/home/home_bloc.dart';
import '../../viewmodel/project/edit_project/edit_project_event.dart';
import '../../viewmodel/project/edit_project/edit_project_state.dart';
import '../../viewmodel/project/edit_project/edit_project_bloc.dart';

class EditProject extends StatelessWidget {
  const EditProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: reusableAppBar("Edit Project"),
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
                    child: BlocConsumer<EditProjectBloc, EditProjectState>(
                        listener: (context, state) {
                      if (state is EditProjectLoadLoading ||
                          state is EditProjectActionLoading) {
                        loadingDialog(context: context);
                      }
                      if (state is EditProjectLoadFailed) {
                        Navigator.pop(context);
                        reusableDialog(
                          context: context,
                          msg: state.message,
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "application",
                              (route) => false,
                            );
                          },
                        );
                      }
                      if (state is EditProjectActionFailed) {
                        Navigator.pop(context);
                        reusableDialog(context: context, msg: state.message);
                      }
                      if (state is EditProjectActionSuccess) {
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
                    }, builder: (context, state) {
                      if (state is EditProjectLoadLoading ||
                          state is EditProjectLoadFailed) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primaryElement,
                          )),
                        );
                      }
                      if (state is EditProjectActionSuccess) {
                        return Container();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ReusableText(
                            text: "Due Date",
                          ),
                          ReusableDatePicker(
                            value: DateFormat("d MMMM y").parse(state.dueDate),
                            onChanged: (date) {
                              context
                                  .read<EditProjectBloc>()
                                  .add(DueDateChangedEvent(dueDate: date));
                            },
                          ),
                          const ReusableText(
                            text: "Project Title",
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          ReusableTextField(
                            initialValue: state.title,
                            iconPath: "assets/icons/file-text.png",
                            hintText: "Enter the project title",
                            iconColor: AppColors.primaryText,
                            onChanged: (value) {
                              context
                                  .read<EditProjectBloc>()
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
                            initialValue: state.description,
                            textInputType: TextInputType.streetAddress,
                            iconPath: "assets/icons/profile_book.png",
                            iconColor: AppColors.primaryText,
                            hintText: "Enter the project description",
                            onChanged: (value) {
                              context.read<EditProjectBloc>().add(
                                  DescriptionChangedEvent(description: value));
                            },
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          ReusableButton(
                              text: "Edit Project",
                              onTap: () {
                                context
                                    .read<EditProjectBloc>()
                                    .add(EditProjectActionEvent());
                              }),
                        ],
                      );
                    })),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
