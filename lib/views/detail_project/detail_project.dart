import 'package:citracker/core/widgets/dialog/loading_dialog.dart';
import 'package:citracker/viewmodel/project/edit_project/edit_project_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color.dart';
import '../../core/widgets/dialog/reusable_dialog.dart';
import '../../core/widgets/text/application_text.dart';
import '../../viewmodel/home/home_bloc.dart';
import '../../viewmodel/project/detail_project/detail_project_bloc.dart';
import '../../viewmodel/project/edit_project/edit_project_bloc.dart';

class DetailProject extends StatelessWidget {
  const DetailProject({super.key});

  @override
  Widget build(BuildContext context) {
    late final String documentId;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryElement,
        child: Icon(
          Icons.add,
          size: 30.w,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            "create_task",
          );
        },
      ),
      backgroundColor: AppColors.primaryElement,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.w),
                    bottomRight: Radius.circular(20.w)),
              ),
            ),
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: 100.h,
              title: const Text(
                "Project Detail",
                style: TextStyle(color: AppColors.primaryElementText),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: AppColors.primaryText),
              leading: Container(
                padding: EdgeInsets.only(left: 10.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.w))),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                BlocListener<DetailProjectBloc, DetailProjectState>(
                  listener: (context, state) {
                    if (state is DeleteProjectLoading) {
                      loadingDialog(context: context);
                    }
                    if (state is DeleteProjectFailed) {
                      Navigator.pop(context);
                      reusableDialog(context: context, msg: state.message);
                    }
                    if (state is DeleteProjectSuccess) {
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
                  child: PopupMenuButton(
                    onSelected: (value) {
                      if (value == "edit_project") {
                        context
                            .read<EditProjectBloc>()
                            .add(EditProjectLoadEvent(documentId: documentId));
                        Navigator.pushNamed(context, value);
                      } else {
                        reusableDialog(
                          context: context,
                          msg:
                              "Are you sure to delete this project permanently?",
                          backgroundColor: Colors.red,
                          onPressed: () {
                            context.read<DetailProjectBloc>().add(
                                DetailProjectDeleteEvent(
                                    documentId: documentId));
                          },
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryBackground,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.w))),
                          ),
                          const IconButton(
                            icon: Icon(
                              Icons.view_headline,
                              color: AppColors.primaryText,
                            ),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: "edit_project",
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.yellow[800],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text("Edit Project")
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "delete_project",
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text("Delete Project")
                            ],
                          ),
                        )
                      ];
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.w),
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
              padding: EdgeInsets.all(20.w),
              child: BlocConsumer<DetailProjectBloc, DetailProjectState>(
                listener: (context, state) {
                  if (state is DetailProjectLoadFailed) {
                    Navigator.pop(context);
                    reusableDialog(
                      context: context,
                      msg: "Error while fetching data: ${state.message}",
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  }
                  if (state is DetailProjectLoadSuccess) {
                    documentId = state.project.id!;
                  }
                },
                builder: (context, state) {
                  if (state is DetailProjectLoadSuccess) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          width: 90.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryFourthElementText,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.w),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 350.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ApplicationText(
                                  text: state.project.title!,
                                  fontSize: 23,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                ApplicationText(
                                  text: state.project.description!,
                                  fontSize: 13,
                                  height: 1.4,
                                  color: AppColors.primarySecondaryElementText,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.pushNamed(context, "export_pdf",
                                //     arguments: <String, String>{
                                //       'title': data['title'],
                                //       'description': data['description'],
                                //       'dueDate': data['due_date'],
                                //     });
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.primaryElement,
                                radius: 16.w,
                                child: Icon(
                                  Icons.print,
                                  color: AppColors.primaryElementText,
                                  size: 16.w,
                                ),
                              ),
                            ),
                            const ApplicationText(
                              text: "5/25 Task Completed",
                              fontSize: 13,
                              height: 1.4,
                              color: AppColors.primaryThirdElementText,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3.w,
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.h,
                          ),
                          itemCount: 6,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.w),
                                    ),
                                    border: Border.all(
                                        color: AppColors
                                            .primaryFourthElementText)),
                                child: Padding(
                                  padding: EdgeInsets.all(15.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Flexible(
                                              child: ApplicationText(
                                                text: "Create UI Design",
                                                textTrucate: true,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 5.w),
                                                    child: const CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        "https://i.ibb.co/PGv8ZzG/me.jpg",
                                                      ),
                                                      radius: 15,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 5.w),
                                                  child: const CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      "https://i.ibb.co/PGv8ZzG/me.jpg",
                                                    ),
                                                    radius: 15,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 5.w),
                                                  child: const CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      "https://i.ibb.co/PGv8ZzG/me.jpg",
                                                    ),
                                                    radius: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.domain_verification,
                                                  color: Colors.green,
                                                  size: 18.w,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                const ApplicationText(
                                                  text: "Completed At:",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                const Expanded(
                                                  child: ApplicationText(
                                                    text: "08 Agustus 2023",
                                                    textTrucate: true,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Center(
                                          child: ApplicationText(
                                        text: "Completed",
                                        fontSize: 13,
                                        color: Colors.green,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryElement),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
