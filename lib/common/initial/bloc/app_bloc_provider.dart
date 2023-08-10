import 'package:citracker/pages/application/bloc/application_bloc.dart';
import 'package:citracker/pages/create_project/bloc/create_project_bloc.dart';
import 'package:citracker/pages/edit_project/bloc/edit_project_bloc.dart';
import 'package:citracker/pages/register/bloc/register_bloc.dart';
import 'package:citracker/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:citracker/pages/welcome/bloc/welcome_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProvider {
  static get getAllBlocProvider => [
        BlocProvider(
          create: (context) => WelcomeBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => ApplicationBloc(),
        ),
        BlocProvider(
          create: (context) => CreateProjectBloc(),
        ),
        BlocProvider(
          create: (context) => EditProjectBloc(),
        ),
      ];
}
