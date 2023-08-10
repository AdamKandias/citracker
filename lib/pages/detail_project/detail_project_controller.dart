import 'package:citracker/common/services/firestore_service.dart';
import 'package:citracker/common/widgets/dialog/reusable_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailProjectController {
  FirestoreService firestoreService = FirestoreService();
  BuildContext context;
  DetailProjectController({required this.context});

  Future<DocumentSnapshot<Map<String, dynamic>>> getOneProject(
      String id) async {
    return await firestoreService.getOne('projects', id);
  }

  Future<dynamic> delete(String id) async {
    try {
      await firestoreService.deleteOne('projects', id);
      Navigator.pushNamedAndRemoveUntil(
        context,
        "application",
        (route) => false,
      );
      return;
    } on FirebaseException catch (e) {
      reusableDialog(
          context: context,
          msg: "Error While Deleting The Project: '${e.message}'");
      return;
    }
  }
}
