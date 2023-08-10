import 'package:citracker/common/widgets/dialog/reusable_dialog.dart';
import 'package:citracker/pages/edit_project/bloc/edit_project_bloc.dart';
import 'package:citracker/pages/edit_project/bloc/edit_project_event.dart';
import 'package:citracker/pages/edit_project/edit_project_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProjectController {
  BuildContext context;
  EditProjectController({required this.context});

  Future<DocumentSnapshot<Map<String, dynamic>>> getOneProject(
      String id) async {
    return await EditProjectServices(context: context).getOneProject(id);
  }

  Future<void> updateProject(String id) async {
    final state = context.read<EditProjectBloc>().state;
    final String title = state.title;
    final String description = state.description;
    final String dueDate = state.dueDate;
    if (title.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Title field can't empty");
      return;
    }
    if (description.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Description field can't empty");
      return;
    }
    if (dueDate.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Due date field can't empty");
      return;
    }
    EditProjectServices(context: context)
        .update(id, title, description, dueDate);
    context.read<EditProjectBloc>().add(TitleChangedEvent(title: ''));
    context
        .read<EditProjectBloc>()
        .add(DescriptionChangedEvent(description: ''));
    context.read<EditProjectBloc>().add(DueDateChangedEvent(dueDate: ''));
  }
}
