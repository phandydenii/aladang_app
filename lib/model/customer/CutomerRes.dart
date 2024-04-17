// ignore_for_file: file_names

import 'package:aladang_app/model/customer/Customer.dart';

class CustomerListRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  List<Customer>? data;

  CustomerListRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  CustomerListRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <Customer>[];
      json['data'].forEach((v) {
        data!.add(Customer.fromJson(v));
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

class CustomerRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  Customer? data;

  CustomerRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  CustomerRes.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    data = json['data'] != null ? Customer.fromJson(json['data']) : null;
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
