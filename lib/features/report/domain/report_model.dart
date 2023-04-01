class ReportModel {
  String? path;
  String? finish;

  ReportModel({this.path, this.finish});

  ReportModel.fromJson(Map<String, dynamic> json) {
    path = json['photoPath'];
    // finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoPath'] = this.path;
    data['finish'] = this.finish;
    return data;
  }
}
