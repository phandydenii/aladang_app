import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../model/paymentmenthod/PaymentMethod.dart';
import '../model/paymentmenthod/PaymentMethodRes.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class PaymentMethodData {
  Future<PaymentMethodListRes> getPaymentMethodAll() async {
    PaymentMethodListRes res = PaymentMethodListRes();
    String url =
        ProviderUrl.basicUrlWebApi + ProviderUrl.getPaymentMethodAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = PaymentMethodListRes.fromJson(jsonDecode(response.body));
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

  Future<PaymentMethodListRes> getPaymentMethodByPage(page) async {
    PaymentMethodListRes res = PaymentMethodListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getPaymentMethodAllByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = PaymentMethodListRes.fromJson(jsonDecode(response.body));
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

  Future<PaymentMethodRes> insertLocation(PaymentMethod req) async {
    PaymentMethodRes res = PaymentMethodRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.createPaymentMethodUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = PaymentMethodRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<PaymentMethodRes> updateLocation(PaymentMethod req) async {
    PaymentMethodRes res = PaymentMethodRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.updatePaymentMethodUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req.toJson()),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(response.body);
        res = PaymentMethodRes.fromJson(map);
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
