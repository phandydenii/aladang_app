// ignore_for_file: file_names

class ExchangeRate {
  int? id;
  String? date;
  int? currencyid;
  int? shopid;
  double? rate;

  ExchangeRate({this.id, this.date, this.currencyid, this.shopid, this.rate});

  ExchangeRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    currencyid = json['currencyid'];
    shopid = json['shopid'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['currencyid'] = currencyid;
    data['shopid'] = shopid;
    data['rate'] = rate;
    return data;
  }
}