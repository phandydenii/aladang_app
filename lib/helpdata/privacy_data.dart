import 'dart:convert';
import 'package:aladang_app/model/privacy/PrivacyRes.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../model/privacy/Privacy.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class PrivacyData {
  Future<PrivacyListRes> getPrivacyAll() async {
    PrivacyListRes res = PrivacyListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getPrivacyAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = PrivacyListRes.fromJson(jsonDecode(response.body));
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

  Future<PrivacyListRes> getPrivacyByPage(page) async {
    PrivacyListRes res = PrivacyListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getPrivacyAllByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = PrivacyListRes.fromJson(jsonDecode(response.body));
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

  Future<PrivacyRes> insertPrivacy(Privacy req) async {
    PrivacyRes res = PrivacyRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.createPrivacyUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = PrivacyRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<PrivacyRes> updatePrivacy(Privacy req) async {
    PrivacyRes res = PrivacyRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.updatePrivacyUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = PrivacyRes.fromJson(map);
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
