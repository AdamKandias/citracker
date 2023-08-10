import 'package:citracker/common/constants/color.dart';
import 'package:citracker/common/widgets/dialog/loading_dialog.dart';
import 'package:citracker/common/widgets/text/application_text.dart';
import 'package:citracker/pages/detail_project/detail_project_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailProject extends StatelessWidget {
  const DetailProject({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    String documentId = args['id'] ?? '';

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
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == "edit_project") {
                      Navigator.pushNamed(context, value,
                          arguments: <String, String>{'id': documentId});
                    } else {
                      loadingDialog(context: context);
                      DetailProjectController(context: context)
                          .delete(documentId);
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
            child: FutureBuilder<DocumentSnapshot<Object?>>(
                future: DetailProjectController(context: context)
                    .getOneProject(documentId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryElement),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching data: ${snapshot.error}'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.data() == null) {
                    return const Center(
                      child: Text('No data available.'),
                    );
                  }
                  var data = snapshot.data!.data() as Map<String, dynamic>;
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
                                text: data['title'],
                                fontSize: 23,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              ApplicationText(
                                text: data['description'],
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
                              Navigator.pushNamed(context, "export_pdf",
                                  arguments: <String, String>{
                                    'title': data['title'],
                                    'description': data['description'],
                                    'dueDate': data['due_date'],
                                  });
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                      color:
                                          AppColors.primaryFourthElementText)),
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
                                                padding:
                                                    EdgeInsets.only(right: 5.w),
                                                child: const CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    "https://i.ibb.co/PGv8ZzG/me.jpg",
                                                  ),
                                                  radius: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 5.w),
                                                child: const CircleAvatar(
                                                  backgroundImage: NetworkImage(
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
                }),
          ),
        ),
      ),
    );
  }
}
