import 'dart:convert';
import 'package:aladang_app/model/exchangerate/ExchangeRate.dart';
import 'package:aladang_app/model/exchangerate/ExchangeRateRes.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../model/auth/SignInRes.dart';
import '../utils/constant.dart';

class ExchangeRateData {
  Future<ExchangeRateListRes> getExchangeRateAll() async {
    ExchangeRateListRes res = ExchangeRateListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getExchangeRateAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ExchangeRateListRes.fromJson(jsonDecode(response.body));
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

  Future<ExchangeRateRes> getExchangeRateByShopId(shopid) async {
    print(shopid);
    ExchangeRateRes res = ExchangeRateRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getExchangeRateByShopIdUrl +
        shopid.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ExchangeRateRes.fromJson(jsonDecode(response.body));
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

  Future<ExchangeRateListRes> getExchangeRateAllByPage(page) async {
    ExchangeRateListRes res = ExchangeRateListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getExchangeRateAllByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ExchangeRateListRes.fromJson(jsonDecode(response.body));
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

  Future<ExchangeRateRes> insertExchangeRate(ExchangeRate req) async {
    ExchangeRateRes res = ExchangeRateRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.createExchangeRateUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = ExchangeRateRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<ExchangeRateRes> updateExchangeRate(ExchangeRate req) async {
    ExchangeRateRes res = ExchangeRateRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.updateExchangeRateUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ExchangeRateRes.fromJson(map);
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
