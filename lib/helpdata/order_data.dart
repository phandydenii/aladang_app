import 'dart:convert';
import 'package:aladang_app/model/order/Order.dart';
import 'package:aladang_app/model/order/OrderRes.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../model/auth/SignInRes.dart';
import '../utils/constant.dart';

class OrderData {
  Future<OrderListRes> getOrderList(page) async {
    OrderListRes res = OrderListRes();
    String url =
        ProviderUrl.basicUrlWebApi + ProviderUrl.getOrderUrl + page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderListRes.fromJson(jsonDecode(response.body));
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

  Future<OrderListRes> getOrderByStatus(status, page) async {
    OrderListRes res = OrderListRes();
    String url =
        "${ProviderUrl.basicUrlWebApi + ProviderUrl.getOrderByStatusUrl + status}&page=$page";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderListRes.fromJson(jsonDecode(response.body));
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

  Future<OrderListRes> getOrderByShopId(shopid, page, status) async {
    OrderListRes res = OrderListRes();
    String url =
        "${ProviderUrl.basicUrlWebApi + ProviderUrl.getOrderByShopIdUrl + shopid.toString()}&page=$page&status=$status";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderListRes.fromJson(jsonDecode(response.body));
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

  Future<OrderRes> getOrderById(orderid) async {
    OrderRes res = OrderRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getOrderByIdUrl +
        orderid.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderRes.fromJson(jsonDecode(response.body));
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

  Future<OrderListRes> getOrderBySCustomerId(customerid, page, status) async {
    OrderListRes res = OrderListRes();
    String url =
        "${ProviderUrl.basicUrlWebApi + ProviderUrl.getOrderByCustomerIdUrl + customerid.toString()}&page=$page&status=$status";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = OrderListRes.fromJson(jsonDecode(response.body));
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

  Future<OrderRes> insertOrder(Order req) async {
    OrderRes res = OrderRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.createOrderUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = OrderRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<OrderRes> updateOrder(Order req) async {
    OrderRes res = OrderRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.updateOrderUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = OrderRes.fromJson(map);
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
