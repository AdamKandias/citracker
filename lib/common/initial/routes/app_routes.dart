import 'package:citracker/pages/application/application.dart';
import 'package:citracker/pages/create_project/create_project.dart';
import 'package:citracker/pages/create_task/create_task.dart';
import 'package:citracker/pages/detail_project/detail_project.dart';
import 'package:citracker/pages/edit_project/edit_project.dart';
import 'package:citracker/pages/register/register.dart';
import 'package:citracker/pages/report/pdf_preview_page.dart';
import 'package:citracker/pages/sign_in/sign_in.dart';
import 'package:citracker/pages/welcome/welcome.dart';

class AppRoutes {
  static get getAllRoute => {
        'welcome': (context) => const Welcome(),
        'sign_in': (context) => const SignIn(),
        'register': (context) => const Register(),
        'application': (context) => const Application(),
        'detail_project': (context) => const DetailProject(),
        'create_project': (context) => const CreateProject(),
        'edit_project': (context) => const EditProject(),
        'create_task': (context) => const CreateTask(),
        'export_pdf': (context) => const PdfPreviewPage(),
      };
}
