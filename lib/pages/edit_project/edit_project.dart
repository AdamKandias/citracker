import 'package:citracker/common/constants/color.dart';
import 'package:citracker/common/widgets/appbar/sign_in_appbar.dart';
import 'package:citracker/common/widgets/button/reusable_button.dart';
import 'package:citracker/common/widgets/datepicker/reusable_datepicker.dart';
import 'package:citracker/common/widgets/dialog/loading_dialog.dart';
import 'package:citracker/common/widgets/text/application_text.dart';
import 'package:citracker/common/widgets/text/reusable_text.dart';
import 'package:citracker/common/widgets/textfield/reusable_text_field.dart';
import 'package:citracker/pages/edit_project/bloc/edit_project_bloc.dart';
import 'package:citracker/pages/edit_project/bloc/edit_project_event.dart';
import 'package:citracker/pages/edit_project/edit_project_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EditProject extends StatelessWidget {
  const EditProject({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    String documentId = args['id'] ?? '';
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
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: EditProjectController(context: context)
                          .getOneProject(documentId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.primaryElement),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // Menampilkan tampilan error jika terjadi kesalahan
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: const Center(
                              child: ApplicationText(
                                text:
                                    "There's no project like that, please back",
                                textAlign: TextAlign.center,
                                color: AppColors.primaryElement,
                              ),
                            ),
                          );
                        } else {
                          // print(snapshot.data!.data()!['due_date']);
                          context.read<EditProjectBloc>().add(TitleChangedEvent(
                              title: snapshot.data!.data()!['title']));
                          context.read<EditProjectBloc>().add(
                              DescriptionChangedEvent(
                                  description:
                                      snapshot.data!.data()!['description']));
                          context.read<EditProjectBloc>().add(
                              DueDateChangedEvent(
                                  dueDate: snapshot.data!.data()!['due_date']));
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ReusableText(
                                text: "Due Date",
                              ),
                              ReusableDatePicker(
                                value: DateFormat("d MMMM y")
                                    .parse(snapshot.data!.data()!['due_date']),
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
                                textEditingController: TextEditingController(
                                    text: snapshot.data!.data()!['title']),
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
                                textEditingController: TextEditingController(
                                    text:
                                        snapshot.data!.data()!['description']),
                                textInputType: TextInputType.emailAddress,
                                iconPath: "assets/icons/profile_book.png",
                                iconColor: AppColors.primaryText,
                                hintText: "Enter the project description",
                                onChanged: (value) {
                                  context.read<EditProjectBloc>().add(
                                      DescriptionChangedEvent(
                                          description: value));
                                },
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              ReusableButton(
                                  text: "Edit Project",
                                  onTap: () {
                                    loadingDialog(context: context);
                                    EditProjectController(context: context)
                                        .updateProject(documentId);
                                  }),
                            ],
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
