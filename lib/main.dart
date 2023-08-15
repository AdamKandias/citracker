import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/color.dart';
import 'core/initial/bloc/app_bloc_provider.dart';
import 'core/initial/routes/app_routes.dart';
import 'core/initial/routes/route_setting.dart';
import 'global.dart';

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
