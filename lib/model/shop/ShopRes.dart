// ignore_for_file: file_names

import 'Shop.dart';

class ShopListRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  List<Shop>? data;

  ShopListRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  ShopListRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <Shop>[];
      json['data'].forEach((v) {
        data!.add(Shop.fromJson(v));
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

class ShopRes {
  int? code;
  String? message;
  int? pageCount;
  int? currentPage;
  Shop? data;

  ShopRes(
      {this.code, this.message, this.pageCount, this.currentPage, this.data});

  ShopRes.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    message = json['message'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    data = json['data'] != null ? Shop.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['pageCount'] = pageCount;
    data['currentPage'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
