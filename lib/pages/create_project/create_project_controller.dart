import 'package:citracker/common/widgets/dialog/reusable_dialog.dart';
import 'package:citracker/pages/create_project/bloc/create_project_bloc.dart';
import 'package:citracker/pages/create_project/bloc/create_project_event.dart';
import 'package:citracker/pages/create_project/create_project_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProjectController {
  BuildContext context;
  CreateProjectController({required this.context});

  Future<void> addNewProject() async {
    final state = context.read<CreateProjectBloc>().state;
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
    CreateProjectServices(context: context).create(title, description, dueDate);
    context.read<CreateProjectBloc>().add(TitleChangedEvent(title: ''));
    context
        .read<CreateProjectBloc>()
        .add(DescriptionChangedEvent(description: ''));
    context.read<CreateProjectBloc>().add(DueDateChangedEvent(dueDate: ''));
  }
}
