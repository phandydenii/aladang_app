// ignore_for_file: file_names

import 'PaymentMethod.dart';

class PaymentMethodListRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  List<PaymentMethod>? data;

  PaymentMethodListRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  PaymentMethodListRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <PaymentMethod>[];
      json['data'].forEach((v) {
        data!.add(PaymentMethod.fromJson(v));
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

class PaymentMethodRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  PaymentMethod? data;

  PaymentMethodRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  PaymentMethodRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    data =
        json['data'] != null ? PaymentMethod.fromJson(json['data']) : null;
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
