// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../viewmodel/project/edit_project/edit_project_bloc.dart';
// import '../../viewmodel/project/edit_project/edit_project_event.dart';
// import 'edit_project_service.dart';

// class EditProjectController {
//   BuildContext context;
//   EditProjectController({required this.context});

//   Future<DocumentSnapshot<Map<String, dynamic>>> getOneProject(
//       String id) async {
//     return await EditProjectServices(context: context).getOneProject(id);
//   }

//   Future<void> updateProject(String id) async {
//     final state = context.read<EditProjectBloc>().state;
//     final String title = state.title;
//     final String description = state.description;
//     final String dueDate = state.dueDate;

//     EditProjectServices(context: context)
//         .update(id, title, description, dueDate);
//     context.read<EditProjectBloc>().add(TitleChangedEvent(title: ''));
//     context
//         .read<EditProjectBloc>()
//         .add(DescriptionChangedEvent(description: ''));
//     context.read<EditProjectBloc>().add(DueDateChangedEvent(dueDate: ''));
//   }
// }
