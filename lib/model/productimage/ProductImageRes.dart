// ignore_for_file: file_names

import 'ProductImage.dart';

class ProductImageListRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  List<ProductImage>? data;

  ProductImageListRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  ProductImageListRes.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <ProductImage>[];
      json['data'].forEach((v) {
        data!.add(ProductImage.fromJson(v));
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

class ProductImageRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  ProductImage? data;

  ProductImageRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  ProductImageRes.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    data =
        json['data'] != null ? ProductImage.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['count'] = count;
    data['countPage'] = countPage;
    data['currentPage'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
