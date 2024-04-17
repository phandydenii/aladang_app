import 'dart:convert';
import 'package:aladang_app/model/shop/ChangeQRCodeImage.dart';
import 'package:aladang_app/model/shop/ResetPassword.dart';
import 'package:aladang_app/model/shop/Shop.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../model/shop/ChangeLogoShop.dart';
import '../model/shop/ChangePasswordShop.dart';
import '../model/shop/ShopRes.dart';
import '../utils/constant.dart';

class ShopData {
  Future<ShopListRes> getShopListAll() async {
    ShopListRes res = ShopListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getShopAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ShopListRes.fromJson(jsonDecode(response.body));
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

  Future<ShopListRes> getShopList(page) async {
    ShopListRes res = ShopListRes();

    String url =
        ProviderUrl.basicUrlWebApi + ProviderUrl.getShopUrl + page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ShopListRes.fromJson(jsonDecode(response.body));
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

  Future<ShopListRes> getOtherShopList(id, page) async {
    ShopListRes res = ShopListRes();
    String url =
        "${ProviderUrl.basicUrlWebApi}${ProviderUrl.getOtherShopUrl}$id&page=$page";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ShopListRes.fromJson(jsonDecode(response.body));
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

  Future<ShopRes> getShopById(id) async {
    ShopRes res = ShopRes();
    String url =
        "${ProviderUrl.basicUrlWebApi}${ProviderUrl.getShopByIdUrl}$id";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = ShopRes.fromJson(jsonDecode(response.body));
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

  Future<ShopRes> insertShop(Shop req) async {
    ShopRes res = ShopRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.createShopUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = ShopRes.fromJson(map);
      } else if (response.statusCode == 401) {
        throw ('Unauthorized. code 401');
      } else if (response.statusCode == 404) {
        throw ('Not Found. code 404 ');
      } else if (response.statusCode == 409) {
        throw ('Duplicate data. code 409');
      } else {
        throw ('Internal Server Error. code 500');
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<ShopRes> updateShop(Shop req) async {
    ShopRes res = ShopRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.updateShopUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ShopRes.fromJson(map);
      } else if (response.statusCode == 401) {
        throw ('Unauthorized. code 401');
      } else if (response.statusCode == 404) {
        throw ('Not Found. code 404 ');
      } else if (response.statusCode == 409) {
        throw ('Duplicate data. code 409');
      } else {
        throw ('Internal Server Error. code 500');
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<ShopRes> resetPasswordShop(ResetPasswordShop req) async {
    ShopRes res = ShopRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.getResetPasswordShopUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ShopRes.fromJson(map);
      } else if (response.statusCode == 401) {
        throw ('Unauthorized. code 401');
      } else if (response.statusCode == 404) {
        throw ('Not Found. code 404 ');
      } else if (response.statusCode == 409) {
        throw ('Duplicate data. code 409');
      } else {
        throw ('Internal Server Error. code 500');
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<ShopRes> changePasswordShop(ChangePaswordShop req) async {
    ShopRes res = ShopRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.getChangePasswordShopUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ShopRes.fromJson(map);
      } else if (response.statusCode == 401) {
        throw ('Unauthorized. code 401');
      } else if (response.statusCode == 404) {
        throw ('Not Found. code 404 ');
      } else if (response.statusCode == 409) {
        throw ('Duplicate data. code 409');
      } else {
        throw ('Internal Server Error. code 500');
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<ShopRes> changeLogoShop(ChangeLogoShopReq req) async {
    ShopRes res = ShopRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.changeLogoShopUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ShopRes.fromJson(map);
      } else if (response.statusCode == 401) {
        throw ('Unauthorized. code 401');
      } else if (response.statusCode == 404) {
        throw ('Not Found. code 404 ');
      } else if (response.statusCode == 409) {
        throw ('Duplicate data. code 409');
      } else {
        throw ('Internal Server Error. code 500');
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<ShopRes> changeQRShop(ChangeQRShopReq req) async {
    ShopRes res = ShopRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.changeQRShopUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = ShopRes.fromJson(map);
      } else if (response.statusCode == 401) {
        throw ('Unauthorized. code 401');
      } else if (response.statusCode == 404) {
        throw ('Not Found. code 404 ');
      } else if (response.statusCode == 409) {
        throw ('Duplicate data. code 409');
      } else {
        throw ('Internal Server Error. code 500');
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
