// ignore_for_file: file_names

import 'Location.dart';

class LocationListRes {
  int? code;
  String? message;
  int? pageCount;
  int? currentPage;
  List<Location>? data;

  LocationListRes({
    this.code,
    this.message,
    this.pageCount,
    this.currentPage,
    this.data,
  });

  LocationListRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <Location>[];
      json['data'].forEach((v) {
        // ignore: unnecessary_new
        data!.add(new Location.fromJson(v));
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

class LocationRes {
  int? code;
  String? message;
  int? pageCount;
  int? currentPage;
  Location? data;

  LocationRes({
    this.code,
    this.message,
    this.pageCount,
    this.currentPage,
    this.data,
  });

  LocationRes.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    // ignore: unnecessary_new
    data = json['data'] != null ? new Location.fromJson(json['data']) : null;
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
