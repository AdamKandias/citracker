import 'package:citracker/common/constants/color.dart';
import 'package:citracker/common/initial/bloc/app_bloc_provider.dart';
import 'package:citracker/common/initial/routes/app_routes.dart';
import 'package:citracker/common/initial/routes/route_setting.dart';
import 'package:citracker/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProvider.getAllBlocProvider,
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: AppColors.primaryText))),
          routes: AppRoutes.getAllRoute,
          onGenerateRoute: (settings) =>
              RouteSetting.generateRouteSettings(settings),
        ),
      ),
    );
  }
}
