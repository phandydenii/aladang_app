class ProductOrderDetailView {
  int? id;
  int? orderid;
  int? productid;
  String? productCode;
  String? productName;
  int? qty;
  double? price;
  double? discount;

  ProductOrderDetailView({
    this.id,
    this.orderid,
    this.productid,
    this.productCode,
    this.productName,
    this.qty,
    this.price,
    this.discount,
  });

  ProductOrderDetailView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderid = json['orderid'];
    productid = json['productid'];
    productCode = json['productCode'];
    productName = json['productName'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderid'] = orderid;
    data['productid'] = productid;
    data['productCode'] = productCode;
    data['productName'] = productName;
    data['qty'] = qty;
    data['price'] = price;
    data['discount'] = discount;
    return data;
  }
}
