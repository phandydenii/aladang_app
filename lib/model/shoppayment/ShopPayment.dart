
// ignore_for_file: file_names

class ShopPayment {
  int? id;
  String? date;
  int? shopid;
  String? paytype;
  String? startdate;
  String? enddate;
  int? amount;
  String? note;

  ShopPayment(
      {this.id,
        this.date,
        this.shopid,
        this.paytype,
        this.startdate,
        this.enddate,
        this.amount,
        this.note});

  ShopPayment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    shopid = json['shopid'];
    paytype = json['paytype'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    amount = json['amount'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['shopid'] = shopid;
    data['paytype'] = paytype;
    data['startdate'] = startdate;
    data['enddate'] = enddate;
    data['amount'] = amount;
    data['note'] = note;
    return data;
  }
}
