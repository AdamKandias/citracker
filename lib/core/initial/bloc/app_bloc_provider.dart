import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../viewmodel/pdf_preview/pdf_preview_bloc.dart';
import '../../blocs/application/application_bloc.dart';
import '../../../viewmodel/home/home_bloc.dart';
import '../../../viewmodel/profile/profile_bloc.dart';
import '../../../viewmodel/project/create_project/create_project_bloc.dart';
import '../../../viewmodel/project/detail_project/detail_project_bloc.dart';
import '../../../viewmodel/project/edit_project/edit_project_bloc.dart';
import '../../../viewmodel/register/register_bloc.dart';
import '../../../viewmodel/sign_in/sign_in_bloc.dart';
import '../../../viewmodel/welcome/welcome_bloc.dart';

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
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc()..add(ProjectLoad()),
        ),
        BlocProvider(
          create: (context) => DetailProjectBloc(),
        ),
        BlocProvider(
          create: (context) => PdfPreviewBloc(),
        ),
      ];
}
