// ignore_for_file: file_names

class Order {
  int? id;
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

  Order(
      {this.id,
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

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
