// ignore_for_file: file_names

import 'Product.dart';

class ProductListRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  List<Product>? data;

  ProductListRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  ProductListRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
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

class ProductRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  Product? data;

  ProductRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  ProductRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    data = json['data'] != null ? Product.fromJson(json['data']) : null;
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
