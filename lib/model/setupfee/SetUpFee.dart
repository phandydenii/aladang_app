
// ignore_for_file: file_names

class SetUpFee {
  int? id;
  String? date;
  String? feetype;
  double? amount;
  String? createby;
  DateTime? createdate;

  SetUpFee(
      {this.id,
        this.date,
        this.feetype,
        this.amount,
        this.createby,
        this.createdate});

  SetUpFee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    feetype = json['feetype'];
    amount = json['amount'];
    createby = json['createby'];
    createdate = json['createdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['feetype'] = feetype;
    data['amount'] = amount;
    data['createby'] = createby;
    data['createdate'] = createdate;
    return data;
  }
}
