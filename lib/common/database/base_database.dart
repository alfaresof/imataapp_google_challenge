import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:imataapp/common/database/base_database_repositry.dart';
import 'package:imataapp/features/auth/model/user.dart';

class DatabaseRepositry extends BaseDatabaseRepositry {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Stream<UserModel>> getName({required String id}) async {
    return db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((event) => UserModel.fromSnapshot(event));
  }

  @override
  Future<String> sendName({required String id, required String name}) async {
    await db.collection('users').doc(id).set({
      'name': name,
      'id': id,
      'reports': [],
    });
    return 'sucess';
  }

  @override
  Future<User?> setPhotoPath(
      {required String id, required String idReport, required String path}) {
    throw UnimplementedError();
  }

  Future<void> newReport(
      {required String id,
      required String description,
      required String path,
      required String location}) async {
    final result = db.collection('reports').doc();
    await result.set({
      'id': id,
      'docid': result.id,
      'desctiption': description,
      'location': location,
      'photoPath': path,
    });
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getReports(
      {required String id}) async {
    return await db.collection('users').where('id', isEqualTo: id).get();
  }

  @override
  Future<Query<Map<String, dynamic>>> getReport({required String id}) async {
    Query<Map<String, dynamic>> result =
        db.collection('reports').where({'id': id});
    return result;
  }
}
