// ignore_for_file: file_names

import 'Banner.dart';

class BannerListRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  List<BannerReq>? data;

  BannerListRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  BannerListRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <BannerReq>[];
      json['data'].forEach((v) {
        data!.add(BannerReq.fromJson(v));
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

class BannerRes {
  int? code;
  String? message;
  int? count;
  int? countPage;
  int? currentPage;
  BannerReq? data;

  BannerRes(
      {this.code,
      this.message,
      this.count,
      this.countPage,
      this.currentPage,
      this.data});

  BannerRes.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    message = json['message'];
    count = json['count'];
    countPage = json['countPage'];
    currentPage = json['currentPage'];
    data = json['data'] != null ? BannerReq.fromJson(json['data']) : null;
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
