import 'package:citracker/core/exceptions/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() => _instance;

  late FirebaseFirestore db;

  FirestoreService._internal() {
    db = FirebaseFirestore.instance;
  }

  Future<DocumentReference<Map<String, dynamic>>> create(
      String collection, Map<String, dynamic> data) async {
    try {
      return await db.collection(collection).add(data);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAll(String collection) async {
    try {
      return await db.collection(collection).get();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message.toString());
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getOne(
      String collection, String id) async {
    try {
      return await db.collection(collection).doc(id).get();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message.toString());
    }
  }

  Future deleteOne(String collection, String id) async {
    try {
      return await db.collection(collection).doc(id).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message.toString());
    }
  }

  Future<void> update(
      String collection, String id, Map<String, dynamic> data) async {
    try {
      return await db.collection(collection).doc(id).update(data);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message.toString());
    }
  }
}
