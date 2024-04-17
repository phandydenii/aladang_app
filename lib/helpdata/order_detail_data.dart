import 'dart:convert';

import 'package:aladang_app/model/order_detail/OrderDetail.dart';
import 'package:aladang_app/model/order_detail/OrderDetailRes.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../model/order_detail/OrderDetailViewModelRes.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class OrderDetailData {
  Future<OrderDetailListRes> getOrderDetailAllList() async {
    OrderDetailListRes res = OrderDetailListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getOrderDetailAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderDetailListRes.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw ('Unauthorized. code 401');
    } else if (response.statusCode == 404) {
      throw ('Not Found. code 404 ');
    } else if (response.statusCode == 409) {
      throw ('Duplicate data. code 409');
    } else {
      throw ('Internal Server Error. code 500');
    }
    return res;
  }

  Future<OrderDetailListRes> getOrderDetailList(page) async {
    OrderDetailListRes res = OrderDetailListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getOrderDetailByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderDetailListRes.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw ('Unauthorized. code 401');
    } else if (response.statusCode == 404) {
      throw ('Not Found. code 404 ');
    } else if (response.statusCode == 409) {
      throw ('Duplicate data. code 409');
    } else {
      throw ('Internal Server Error. code 500');
    }
    return res;
  }

  Future<OrderDetailListRes> getOrderDetailByOrderId(orderid) async {
    OrderDetailListRes res = OrderDetailListRes();
    String url =
        "${ProviderUrl.basicUrlWebApi}${ProviderUrl.getOrderDetailByOrderIdUrl}$orderid";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderDetailListRes.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw ('Unauthorized. code 401');
    } else if (response.statusCode == 404) {
      throw ('Not Found. code 404 ');
    } else if (response.statusCode == 409) {
      throw ('Duplicate data. code 409');
    } else {
      throw ('Internal Server Error. code 500');
    }
    return res;
  }

  Future<OrderDetailViewModelRes> getOrderDetailDetailView(orderid) async {
    OrderDetailViewModelRes res = OrderDetailViewModelRes();
    String url =
        "${ProviderUrl.basicUrlWebApi}${ProviderUrl.getOrderDetailViewUrl}$orderid";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderDetailViewModelRes.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw ('Unauthorized. code 401');
    } else if (response.statusCode == 404) {
      throw ('Not Found. code 404 ');
    } else if (response.statusCode == 409) {
      throw ('Duplicate data. code 409');
    } else {
      throw ('Internal Server Error. code 500');
    }
    return res;
  }

  Future<OrderDetailRes> insertOrderDetail(OrderDetail req) async {
    OrderDetailRes res = OrderDetailRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.createOrderDetailUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = OrderDetailRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<OrderDetailRes> updateOrderDetail(OrderDetail req) async {
    OrderDetailRes res = OrderDetailRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.updateOrderDetailUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = OrderDetailRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  String getToken() {
    final localStorage = LocalStorage("TOKEN_APP");
    var accessToken = localStorage.getItem("ACCESS_TOKEN");
    SignInRes loginRes = SignInRes.fromJson(accessToken);
    return loginRes.data!.token!;
  }
}
