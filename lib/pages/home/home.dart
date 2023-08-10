import 'package:citracker/common/constants/color.dart';
import 'package:citracker/common/services/firebase_auth_service.dart';
import 'package:citracker/common/widgets/button/reusable_button.dart';
import 'package:citracker/pages/home/home_controller.dart';
import 'package:citracker/pages/home/widgets/home_search.dart';
import 'package:citracker/common/widgets/text/application_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
              FutureBuilder<QuerySnapshot>(
                  future: HomeController(context: context).getAllProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryElement),
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const Center(
                          child: ApplicationText(
                            text:
                                "There's no project right now!\nYou can add the project",
                            textAlign: TextAlign.center,
                            color: AppColors.primaryElement,
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.1.w,
                        crossAxisCount: 1,
                        mainAxisSpacing: 13.h,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        String documentId = snapshot.data!.docs[index].id;
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "detail_project",
                                arguments: <String, String>{'id': documentId});
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
                                          text: data['title'],
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
                                                text: data['due_date'],
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
                                          Navigator.pushNamed(
                                              context, "detail_project",
                                              arguments: <String, String>{
                                                'id': documentId
                                              });
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
                                            color: AppColors.primaryElementText,
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
