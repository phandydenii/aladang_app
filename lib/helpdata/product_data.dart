import 'dart:convert';

import 'package:aladang_app/model/product/ProductRes.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../model/product/Product.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class ProductData {
  Future<ProductListRes> getProductAll() async {
    ProductListRes res = ProductListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getProductAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ProductListRes.fromJson(jsonDecode(response.body));
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

  Future<ProductListRes> getProductList(page) async {
    ProductListRes res = ProductListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getProductUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ProductListRes.fromJson(jsonDecode(response.body));
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

  Future<ProductListRes> getProductByStatus(status, page) async {
    ProductListRes res = ProductListRes();
    String url =
        "${ProviderUrl.basicUrlWebApi + ProviderUrl.getProductByStatusUrl + status}&page=$page";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ProductListRes.fromJson(jsonDecode(response.body));
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

  Future<ProductListRes> getProductByShopId(shopid, page, status) async {
    ProductListRes res = ProductListRes();
    String url =
        "${ProviderUrl.basicUrlWebApi + ProviderUrl.getProductByShopIdUrl + shopid.toString()}&page=$page&status=$status";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ProductListRes.fromJson(jsonDecode(response.body));
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

  Future<ProductRes> getProductByID(id) async {
    ProductRes res = ProductRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getProductByIDUrl +
        id.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ProductRes.fromJson(jsonDecode(response.body));
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

  Future<ProductRes> insertProduct(Product req) async {
    ProductRes res = ProductRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.createProductUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ProductRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<ProductRes> updateProduct(Product req) async {
    ProductRes res = ProductRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.updateProductUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ProductRes.fromJson(map);
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
