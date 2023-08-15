import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color.dart';
import '../../core/widgets/application_widget.dart';
import '../../core/widgets/bottom_navigation_bar_items.dart';
import '../../core/blocs/application/application_bloc.dart';
import '../../core/blocs/application/application_event.dart';
import '../../core/blocs/application/application_state.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
            body: applicationPage(state.page),
            bottomNavigationBar: Container(
              width: 375.w,
              height: 58.h,
              decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: AppColors.primaryElement,
                  unselectedItemColor: AppColors.primaryFourthElementText,
                  showUnselectedLabels: false,
                  elevation: 0,
                  onTap: (value) => context
                      .read<ApplicationBloc>()
                      .add(ApplicationPageChangedEvent(index: value)),
                  currentIndex: state.page,
                  items: bottomNavigationBarItems()),
            ),
          )),
        );
      },
    );
  }
}
