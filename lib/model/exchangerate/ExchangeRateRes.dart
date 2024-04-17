// ignore_for_file: file_names

import 'ExchangeRate.dart';

class ExchangeRateListRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  List<ExchangeRate>? data;

  ExchangeRateListRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  ExchangeRateListRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <ExchangeRate>[];
      json['data'].forEach((v) {
        data!.add(ExchangeRate.fromJson(v));
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

class ExchangeRateRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  ExchangeRate? data;

  ExchangeRateRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  ExchangeRateRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    data =
        json['data'] != null ? ExchangeRate.fromJson(json['data']) : null;
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
