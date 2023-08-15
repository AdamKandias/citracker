import '../../../views/application/application.dart';
import '../../../views/create_project/create_project.dart';
import '../../../views/create_task/create_task.dart';
import '../../../views/detail_project/detail_project.dart';
import '../../../views/edit_project/edit_project.dart';
import '../../../views/register/register.dart';
import '../../../views/pdf_preview/pdf_preview_page.dart';
import '../../../views/sign_in/sign_in.dart';
import '../../../views/welcome/welcome.dart';

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
