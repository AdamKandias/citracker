import 'package:citracker/common/services/firestore_service.dart';
import 'package:citracker/common/widgets/dialog/reusable_dialog.dart';
import 'package:flutter/material.dart';

class CreateProjectServices {
  FirestoreService firestoreService = FirestoreService();
  BuildContext context;
  CreateProjectServices({required this.context});

  Future<void> create(String title, String description, String dueDate) async {
    try {
      await firestoreService.create('projects', {
        "title": title,
        "description": description,
        "due_date": dueDate,
      });
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Successfully create new project");
      Navigator.pushNamedAndRemoveUntil(
        context,
        'application',
        (route) => false,
      );
    } catch (e) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: e.toString());
    }
  }
}
