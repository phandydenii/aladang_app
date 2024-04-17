// ignore_for_file: file_names

class PaymentMethod {
  int? id;
  String? methodname;
  String? createby;
  String? createdate;
  bool? status;

  PaymentMethod({this.id, this.methodname, this.createby, this.createdate, this.status});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodname = json['methodname'];
    createby = json['createby'];
    createdate = json['createdate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['methodname'] = methodname;
    data['createby'] = createby;
    data['createdate'] = createdate;
    data['status'] = status;
    return data;
  }
}
