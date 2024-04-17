// ignore_for_file: file_names

class OrderDetail {
  int? id;
  int? orderid;
  int? productid;
  int? qty;
  double? price;
  double? discount;

  OrderDetail(
      {this.id,
      this.orderid,
      this.productid,
      this.qty,
      this.price,
      this.discount});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderid = json['orderid'];
    productid = json['productid'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderid'] = orderid;
    data['productid'] = productid;
    data['qty'] = qty;
    data['price'] = price;
    data['discount'] = discount;
    return data;
  }
}
