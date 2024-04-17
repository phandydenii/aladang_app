// ignore_for_file: file_names

class ProductImage {
  int? id;
  int? productid;
  String? productimage;

  ProductImage({this.id, this.productid, this.productimage});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productid = json['productid'];
    productimage = json['productimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productid'] = productid;
    data['productimage'] = productimage;
    return data;
  }
}