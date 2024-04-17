// ignore_for_file: file_names

import 'DeliveryType.dart';

class DeliveryTypeListRes {
  int? code;
  String? message;
  int? pageCount;
  int? currentPage;
  List<DeliveryType>? data;

  DeliveryTypeListRes(
      {this.code, this.message, this.pageCount, this.currentPage, this.data});

  DeliveryTypeListRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <DeliveryType>[];
      json['data'].forEach((v) {
        data!.add(DeliveryType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['pageCount'] = pageCount;
    data['currentPage'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryTypeRes {
  int? code;
  String? message;
  int? pageCount;
  int? currentPage;
  DeliveryType? data;

  DeliveryTypeRes(
      {this.code, this.message, this.pageCount, this.currentPage, this.data});

  DeliveryTypeRes.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    message = json['message'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    data =
        json['data'] != null ? DeliveryType.fromJson(json['data']) : null;
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
