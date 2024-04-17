// ignore_for_file: file_names

class Privacy {
  int? id;
  String? description;

  Privacy({this.id, this.description});

  Privacy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    return data;
  }
}
