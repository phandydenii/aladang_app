// ignore_for_file: file_names

class OrderDetailViewModelRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  List<OrderDetailView>? data;

  OrderDetailViewModelRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  OrderDetailViewModelRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <OrderDetailView>[];
      json['data'].forEach((v) {
        data!.add(OrderDetailView.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['count'] = count;
    data['countPage'] = countPage;
    data['currentPage'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetailView {
  int? id;
  int? orderid;
  int? productid;
  String? productCode;
  String? productName;
  int? qty;
  double? price;
  double? discount;
  int? invoiceNo;
  String? date;
  int? shopId;
  int? customerId;
  String? deliveryTypeIn;
  String? currentLocation;
  String? phone;
  String? paymentType;
  String? qrcodeShopName;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? receiptUpload;
  double? amountTobePaid;
  int? exchangeId;
  String? status;

  OrderDetailView(
      {this.id,
      this.orderid,
      this.productid,
      this.productCode,
      this.productName,
      this.qty,
      this.price,
      this.discount,
      this.invoiceNo,
      this.date,
      this.shopId,
      this.customerId,
      this.deliveryTypeIn,
      this.currentLocation,
      this.phone,
      this.paymentType,
      this.qrcodeShopName,
      this.bankName,
      this.accountNumber,
      this.accountName,
      this.receiptUpload,
      this.amountTobePaid,
      this.exchangeId,
      this.status});

  OrderDetailView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderid = json['orderid'];
    productid = json['productid'];
    productCode = json['productCode'];
    productName = json['productName'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
    invoiceNo = json['invoiceNo'];
    date = json['date'];
    shopId = json['shopId'];
    customerId = json['customerId'];
    deliveryTypeIn = json['deliveryTypeIn'];
    currentLocation = json['currentLocation'];
    phone = json['phone'];
    paymentType = json['paymentType'];
    qrcodeShopName = json['qrcodeShopName'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    receiptUpload = json['receiptUpload'];
    amountTobePaid = json['amountTobePaid'];
    exchangeId = json['exchangeId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderid'] = orderid;
    data['productid'] = productid;
    data['qty'] = qty;
    data['price'] = price;
    data['discount'] = discount;
    data['invoiceNo'] = invoiceNo;
    data['date'] = date;
    data['shopId'] = shopId;
    data['customerId'] = customerId;
    data['deliveryTypeIn'] = deliveryTypeIn;
    data['currentLocation'] = currentLocation;
    data['phone'] = phone;
    data['paymentType'] = paymentType;
    data['qrcodeShopName'] = qrcodeShopName;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['accountName'] = accountName;
    data['receiptUpload'] = receiptUpload;
    data['amountTobePaid'] = amountTobePaid;
    data['exchangeId'] = exchangeId;
    data['status'] = status;
    return data;
  }
}
