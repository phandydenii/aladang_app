import 'dart:convert';
import 'package:aladang_app/model/setupfee/SetUpFeeRes.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/SetUpFee/SetUpFee.dart';
import '../model/auth/SignInRes.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class SetUpFeeData {
  Future<SetUpFeeRes> getSetUpFeeAll() async {
    SetUpFeeRes res = SetUpFeeRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getSetupFeeAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = SetUpFeeRes.fromJson(jsonDecode(response.body));
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

  Future<SetUpFeeRes> getSetUpFeeByPage(page) async {
    SetUpFeeRes res = SetUpFeeRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getSetupFeeByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = SetUpFeeRes.fromJson(jsonDecode(response.body));
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

  Future<SetUpFeeRes> insertSetUpFee(SetUpFee req) async {
    SetUpFeeRes res = SetUpFeeRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.createSetupFeeUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = SetUpFeeRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<SetUpFeeRes> updateSetUpFee(SetUpFee req) async {
    SetUpFeeRes res = SetUpFeeRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.updateSetupFeeUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = SetUpFeeRes.fromJson(map);
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
