// ignore_for_file: file_names

class Product {
  int? id;
  int? shopId;
  String? productCode;
  String? productName;
  String? description;
  int? qtyInStock;
  double? price;
  int? currencyId;
  String? cutStockType;
  String? expiredDate;
  String? linkVideo;
  String? imageThumbnail;
  String? status;

  Product(
      {this.id,
        this.shopId,
        this.productCode,
        this.productName,
        this.description,
        this.qtyInStock,
        this.price,
        this.currencyId,
        this.cutStockType,
        this.expiredDate,
        this.linkVideo,
        this.imageThumbnail,
        this.status});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shopId'];
    productCode = json['productCode'];
    productName = json['productName'];
    description = json['description'];
    qtyInStock = json['qtyInStock'];
    price = json['price'];
    currencyId = json['currencyId'];
    cutStockType = json['cutStockType'];
    expiredDate = json['expiredDate'];
    linkVideo = json['linkVideo'];
    imageThumbnail = json['imageThumbnail'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shopId'] = shopId;
    data['productCode'] = productCode;
    data['productName'] = productName;
    data['description'] = description;
    data['qtyInStock'] = qtyInStock;
    data['price'] = price;
    data['currencyId'] = currencyId;
    data['cutStockType'] = cutStockType;
    data['expiredDate'] = expiredDate;
    data['linkVideo'] = linkVideo;
    data['imageThumbnail'] = imageThumbnail;
    data['status'] = status;
    return data;
  }
}
