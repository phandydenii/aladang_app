// ignore_for_file: file_names

import 'SignInReq.dart';

class SignInRes {
  int? code;
  String? message;
  SignInReq? data;

  SignInRes({this.code, this.message, this.data});

  SignInRes.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? SignInReq.fromJson(json['data']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
