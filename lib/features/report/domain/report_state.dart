import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:imataapp/features/report/domain/report_model.dart';

class NewReportState {
  final TextEditingController description;
  final List output;
  final File file;
  final bool loading;
  final List<ReportModel> reports;

  NewReportState({
    required this.description,
    required this.output,
    required this.file,
    required this.loading,
    required this.reports,
  });

  factory NewReportState.Initial() {
    return NewReportState(
      description: TextEditingController(),
      output: [],
      file: File(''),
      loading: false,
      reports: [],
    );
  }

  NewReportState copyWith({
    TextEditingController? description,
    List? output,
    File? file,
    bool? loading,
    List<ReportModel>? reports,
  }) {
    return NewReportState(
        description: description ?? this.description,
        output: output ?? this.output,
        file: file ?? this.file,
        loading: loading ?? this.loading,
        reports: reports ?? this.reports);
  }
}
