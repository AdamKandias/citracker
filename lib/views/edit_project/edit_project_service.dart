// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../../core/widgets/dialog/reusable_dialog.dart';
// import '../../services/firestore_service.dart';

// class EditProjectServices {
//   FirestoreService firestoreService = FirestoreService();
//   BuildContext context;
//   EditProjectServices({required this.context});

//   Future<DocumentSnapshot<Map<String, dynamic>>> getOneProject(
//       String id) async {
//     return await firestoreService.getOne('projects', id);
//   }

//   Future<void> update(
//       String id, String title, String description, String dueDate) async {
//     try {
//       await firestoreService.update('projects', id, {
//         "title": title,
//         "description": description,
//         "due_date": dueDate,
//       });
//       Navigator.pop(context);
//       reusableDialog(context: context, msg: "Successfully Update the project");
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         'application',
//         (route) => false,
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       reusableDialog(context: context, msg: e.toString());
//     }
//   }
// }
