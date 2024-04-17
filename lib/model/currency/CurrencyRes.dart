// ignore_for_file: file_names

import 'package:aladang_app/model/currency/Currency.dart';

class CurrencyListRes {
  int? code;
  String? message;
  int? pageCount;
  int? currentPage;
  List<Currency>? data;

  CurrencyListRes(
      {this.code, this.message, this.pageCount, this.currentPage, this.data});

  CurrencyListRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <Currency>[];
      json['data'].forEach((v) {
        data!.add(Currency.fromJson(v));
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

class CurrencyRes {
  int? code;
  String? message;
  int? pageCount;
  int? currentPage;
  Currency? data;

  CurrencyRes(
      {this.code, this.message, this.pageCount, this.currentPage, this.data});

  CurrencyRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    data = json['data'] != null ? Currency.fromJson(json['data']) : null;
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
