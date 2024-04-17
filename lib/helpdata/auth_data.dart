import 'dart:convert';
import 'package:aladang_app/model/auth/SignInRes.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:http/http.dart' as http;
import '../model/auth/SignInReq.dart';

class AuthenticationData {
  Future<SignInRes> loginUser(SignInReq req) async {
    SignInRes res = SignInRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.loginUserAppUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(req),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = SignInRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }
}
