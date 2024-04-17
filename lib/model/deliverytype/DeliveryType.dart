// ignore_for_file: file_names

class DeliveryType {
  int? id;
  String? deliveryName;
  String? status;

  DeliveryType({this.id, this.deliveryName, this.status});

  DeliveryType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryName = json['delivery_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['delivery_name'] = deliveryName;
    data['status'] = status;
    return data;
  }
}