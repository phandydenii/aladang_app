import 'dart:convert';

import 'package:aladang_app/model/banner/Banner.dart';
import 'package:aladang_app/model/banner/BannerRes.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class BannerData {
  Future<BannerListRes> getBannerAll() async {
    BannerListRes res = BannerListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getBannerAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = BannerListRes.fromJson(jsonDecode(response.body));
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

  Future<BannerListRes> getBannerById(int id) async {
    BannerListRes res = BannerListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getBannerByIdUrl +
        id.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = BannerListRes.fromJson(jsonDecode(response.body));
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

  Future<BannerListRes> getBannerByPage(int page) async {
    BannerListRes res = BannerListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getBannerByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = BannerListRes.fromJson(jsonDecode(response.body));
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

  Future<BannerListRes> getBannerByShopAndPage(int shopid, int page) async {
    BannerListRes res = BannerListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getBannerByShopUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = BannerListRes.fromJson(jsonDecode(response.body));
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

  Future<BannerRes> insertBanner(BannerReq req) async {
    BannerRes res = BannerRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.createBannertUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        res = BannerRes.fromJson(jsonDecode(response.body));
        // final Map map = SSjson.decode(utf8.decode(response.bodyBytes));
        // res = CurrencyRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<BannerRes> updateBanner(BannerReq req) async {
    BannerRes res = BannerRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.updateBannerUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        //res = CurrencyRes.fromJson(jsonDecode(response.body));
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = BannerRes.fromJson(map);
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
