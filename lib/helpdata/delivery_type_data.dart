import 'dart:convert';

import 'package:aladang_app/model/deliverytype/DeliveryType_Res.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../model/deliverytype/DeliveryType.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class DeliveryTypeData {
  Future<DeliveryTypeListRes> getDeliveryList() async {
    DeliveryTypeListRes res = DeliveryTypeListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getDeliveryTypeAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = DeliveryTypeListRes.fromJson(jsonDecode(response.body));
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

  Future<DeliveryTypeRes> insertDelivery(DeliveryType req) async {
    DeliveryTypeRes res = DeliveryTypeRes();
    try {
      String url = "http://localhost:55131/api/v1/deliverytype";
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        //res = DeliveryTypeRes.fromJson(jsonDecode(response.body));
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = DeliveryTypeRes.fromJson(map);
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
