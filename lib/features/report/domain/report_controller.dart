import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/common/database/base_database.dart';
import 'package:imataapp/features/auth/domain/auth_controller.dart';
import 'package:imataapp/features/auth/domain/sign_up_controller.dart';
import 'package:imataapp/features/report/domain/report_model.dart';
import 'package:imataapp/features/report/domain/report_state.dart';
import 'package:tflite/tflite.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NewReportNotifier extends StateNotifier<NewReportState> {
  NewReportNotifier() : super(NewReportState.initial());

  void loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  void setImage(String path) {
    state = state.copyWith(file: File(path));
  }

  void classifyImage() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    var output = await Tflite.runModelOnImage(
      path: state.file.path,
      numResults: 2,
      threshold: 0.5,
      imageStd: 127.5,
      imageMean: 127.5,
    );
    state = state.copyWith(output: output);
  }

  Future<void> getReports(ref) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final stateSignUp = ref.watch(signUpProvider);
    final stateLogIn = ref.watch(logInProvider);

    final res = await db
        .collection('reports')
        .where('id',
            isEqualTo: stateLogIn.id.toString().isNotEmpty
                ? stateLogIn.id
                : stateSignUp.id)
        .get();
    List<ReportModel> result = [];
    for (var element in res.docs) {
      result.add(ReportModel.fromJson(element.data()));
    }
    state = state.copyWith(reports: result);
  }

  Future<void> uploadImageAndSetReport(ref) async {
    final firebase_storage.FirebaseStorage stor =
        firebase_storage.FirebaseStorage.instance;
    final stateLogIn = ref.watch(logInProvider);
    final stateSignUp = ref.watch(signUpProvider);
    String urlup = "";

    try {
      var now = DateTime.now();

      var email =
          stateLogIn.id.toString().isNotEmpty ? stateLogIn.id : stateSignUp.id;
      var fileName =
          '$email-${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}';
      var result = stor.ref('files/$fileName');
      final fileResponse = await result.putFile(
        File(state.file.path),
      );
      urlup = await fileResponse.ref.getDownloadURL();
    } catch (_) {}
    var id =
        stateLogIn.id.toString().isNotEmpty ? stateLogIn.id : stateSignUp.id;
    await DatabaseRepositry().newReport(
        id: id, description: state.description.text, path: urlup, location: "");
  }

  void reset() {
    state = state.copyWith(
      file: File(''),
      description: TextEditingController(),
      output: [],
    );
  }
}

final nweReportProvider =
    StateNotifierProvider<NewReportNotifier, NewReportState>((ref) {
  return NewReportNotifier();
});
