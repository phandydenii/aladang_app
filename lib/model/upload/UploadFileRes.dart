// ignore_for_file: file_names

class UploadFileRes {
  String? filename;

  UploadFileRes({this.filename});

  UploadFileRes.fromJson(Map<dynamic, dynamic> json) {
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    return data;
  }
}
