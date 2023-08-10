import 'package:citracker/common/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeController {
  FirestoreService firestoreService = FirestoreService();
  BuildContext context;
  HomeController({required this.context});

  Future<QuerySnapshot<Map<String, dynamic>>> getAllProjects() async {
    return await firestoreService.getAll('projects');
  }
}
