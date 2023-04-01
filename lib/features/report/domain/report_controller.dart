import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/common/database/base_database.dart';
import 'package:imataapp/common/upload_image/image_repositry.dart';
import 'package:imataapp/features/auth/domain/auth_controller.dart';
import 'package:imataapp/features/auth/domain/sign_up_controller.dart';
import 'package:imataapp/features/report/domain/report_model.dart';
import 'package:imataapp/features/report/domain/report_state.dart';
import 'package:tflite/tflite.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final nweReportProvider =
    StateNotifierProvider<NewReportNotifier, NewReportState>((ref) {
  return NewReportNotifier();
});

class NewReportNotifier extends StateNotifier<NewReportState> {
  NewReportNotifier() : super(NewReportState.Initial());

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
    print('result is :');
    print(output);
  }

  Future<void> getReports(ref) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final stateSignUp = ref.watch(signUpProvider);
    final res = await db
        .collection('reports')
        .where('id', isEqualTo: stateSignUp.id)
        .get();
    List<ReportModel> result = [];
    res.docs.forEach((element) {
      result.add(ReportModel.fromJson(element.data()));
    });
    // print(result[3].path);
    state = state.copyWith(reports: result);
  }

  void uploadImageAndSetReport(ref) async {
    final firebase_storage.FirebaseStorage stor =
        firebase_storage.FirebaseStorage.instance;
    final stateLogIn = ref.watch(logInProvider);
    final stateSignUp = ref.watch(signUpProvider);
    String urlup = "";

    try {
      var result = await stor.ref('files/image');
      if (stateSignUp.id != null) {
        var result = await stor.ref('files/${state.file.path}');
      } else if (stateLogIn.id != null) {
        var result = await stor.ref('files/${state.file.path}');
      } else {}

      final snapshot = await result.putFile(File(state.file.path));
      urlup = await snapshot.ref.getDownloadURL();
      print(urlup);
    } catch (_) {}
    if (stateLogIn.id.toString().isNotEmpty) {
      final result = DatabaseRepositry().newReport(
          id: stateLogIn.id.toString(),
          description: state.description.text,
          path: urlup,
          location: "");
      print(result);
    } else {
      final result = DatabaseRepositry().newReport(
          id: stateSignUp.id.toString(),
          description: state.description.text,
          path: urlup,
          location: "");
      print(result);
    }
  }
}
