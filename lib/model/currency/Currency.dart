// ignore_for_file: file_names

class Currency {
  int? id;
  String? currencyname;
  String? sign;
  String? status;

  Currency({this.id, this.currencyname, this.sign, this.status});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currencyname = json['currencyname'];
    sign = json['sign'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currencyname'] = currencyname;
    data['sign'] = sign;
    data['status'] = status;
    return data;
  }
}