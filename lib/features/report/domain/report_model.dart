class ReportModel {
  String? path;
  String? finish;

  ReportModel({this.path, this.finish});

  ReportModel.fromJson(Map<String, dynamic> json) {
    path = json['photoPath'];
    // finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photoPath'] = path;
    data['finish'] = finish;
    return data;
  }
}
