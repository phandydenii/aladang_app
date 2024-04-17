// ignore_for_file: file_names

class Location {
  int? id;
  String? location;
  String? active;

  Location({
      this.id, 
      this.location, 
      this.active,});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    //final map = <String, dynamic>{};
    map['id'] = id;
    map['location'] = location;
    map['active'] = active;
    return map;
  }

}