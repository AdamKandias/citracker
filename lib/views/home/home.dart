import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../core/constants/color.dart';
import '../../core/widgets/button/reusable_button.dart';
import '../../core/widgets/text/application_text.dart';
import '../../services/firebase_auth_service.dart';
import '../../viewmodel/home/home_bloc.dart';
import '../../viewmodel/project/detail_project/detail_project_bloc.dart';
import 'widgets/home_search.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySecondaryBackground,
      appBar: AppBar(
        elevation: 1,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 7.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
                width: 20.w,
                child: Image.asset(
                  "assets/icons/menu.png",
                ),
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FirebaseAuthService().getUser()!.displayName!,
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 14.sp),
                      ),
                      Text(
                        "Don't Worry, Be Happy😄",
                        style: TextStyle(
                            color: AppColors.primarySecondaryElementText,
                            fontSize: 8.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                        backgroundImage:
                            const AssetImage("assets/icons/headpic.png"),
                        radius: 15.w),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                  width: 350.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ApplicationText(text: "Let's Create &"),
                      SizedBox(
                        height: 5.h,
                      ),
                      const ApplicationText(
                          text: "Completing Your Task Project 👨‍💻"),
                    ],
                  )),
              const HomeSearch(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  ReusableButton(
                      text: "Add New Project",
                      height: 35,
                      width: 320,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      backgroundColor: const Color.fromARGB(255, 0, 122, 255),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "create_project",
                        );
                      })
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is ProjectLoadLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryElement),
                      ),
                    );
                  }
                  if (state is ProjectLoadFailed) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: ApplicationText(
                            text: "Error while fetching data: ${state.message}",
                            fontSize: 20),
                      ),
                    );
                  }
                  if (state is ProjectLoadSuccess) {
                    if (state.projects.isNotEmpty) {
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2.1.w,
                          crossAxisCount: 1,
                          mainAxisSpacing: 13.h,
                        ),
                        itemCount: state.projects.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context.read<DetailProjectBloc>().add(
                                  DetailProjectLoadEvent(
                                      documentId: state.projects[index].id!));
                              Navigator.pushNamed(
                                context,
                                "detail_project",
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.w),
                                  )),
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
                                          ApplicationText(
                                            text: state.projects[index].title!,
                                            fontSize: 18,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const ApplicationText(
                                                text: "Participants",
                                                color: AppColors
                                                    .primarySecondaryElementText,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Row(
                                                children: [
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
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: AppColors.primaryElement,
                                                size: 18.w,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              const ApplicationText(
                                                text: "Time Limit:",
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Expanded(
                                                child: ApplicationText(
                                                  text: state
                                                      .projects[index].dueDate!,
                                                  textTrucate: true,
                                                  fontSize: 12,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 25.w,
                                          lineWidth: 5.w,
                                          percent: 0.67,
                                          progressColor: Colors.green,
                                          backgroundColor: Colors.black12,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          center: const ApplicationText(
                                            text: "67%",
                                            fontSize: 10,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<DetailProjectBloc>()
                                                .add(DetailProjectLoadEvent(
                                                    documentId: state
                                                        .projects[index].id!));
                                            Navigator.pushNamed(
                                              context,
                                              "detail_project",
                                            );
                                          },
                                          child: Container(
                                            width: 80.w,
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryElement,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12.w),
                                              ),
                                            ),
                                            child: const Center(
                                                child: ApplicationText(
                                              text: "Detail",
                                              fontSize: 14,
                                              color:
                                                  AppColors.primaryElementText,
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const Center(
                          child: ApplicationText(
                              text:
                                  "There are no projects available at the moment, you can create it or relax",
                              fontSize: 20),
                        ),
                      );
                    }
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Center(
                      child: ApplicationText(
                          text: "Unknown error, please contact admin",
                          fontSize: 20),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
