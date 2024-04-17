import 'dart:convert';
import 'package:aladang_app/model/productimage/ProductImageRes.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/ProductImage/ProductImage.dart';
import '../model/auth/SignInRes.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class ProductImageData {
  Future<ProductImageRes> getProductImageAll() async {
    ProductImageRes res = ProductImageRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getProductImageAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ProductImageRes.fromJson(jsonDecode(response.body));
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

  Future<ProductImageRes> getProductImageByPage(page) async {
    ProductImageRes res = ProductImageRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getProductImageAllByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ProductImageRes.fromJson(jsonDecode(response.body));
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

  Future<ProductImageRes> insertProductImage(ProductImage req) async {
    ProductImageRes res = ProductImageRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.createProductImageUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ProductImageRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<ProductImageRes> updateProductImage(ProductImage req) async {
    ProductImageRes res = ProductImageRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.updateProductImageUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ProductImageRes.fromJson(map);
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
