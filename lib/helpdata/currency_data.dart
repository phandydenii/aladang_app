import 'dart:convert';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../model/currency/Currency.dart';
import '../model/currency/CurrencyRes.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class CurrencyData {
  Future<CurrencyListRes> getCurrencyAll() async {
    CurrencyListRes res = CurrencyListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getCurrencyAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = CurrencyListRes.fromJson(jsonDecode(response.body));
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

  Future<CurrencyListRes> getCurrencyAllByPage(page) async {
    CurrencyListRes res = CurrencyListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getCurrencyAllByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = CurrencyListRes.fromJson(jsonDecode(response.body));
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

  Future<CurrencyRes> getCurrencyById(id) async {
    CurrencyRes res = CurrencyRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getCurrencyByIdUrl +
        id.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = CurrencyRes.fromJson(jsonDecode(response.body));
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

  Future<CurrencyRes> insertCurrency(Currency req) async {
    CurrencyRes res = CurrencyRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.createCurrencyUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        res = CurrencyRes.fromJson(jsonDecode(response.body));
        // final Map map = SSjson.decode(utf8.decode(response.bodyBytes));
        // res = CurrencyRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<CurrencyRes> updateCurrency(Currency req) async {
    CurrencyRes res = CurrencyRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.updateCurrencyUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        //res = CurrencyRes.fromJson(jsonDecode(response.body));
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = CurrencyRes.fromJson(map);
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
