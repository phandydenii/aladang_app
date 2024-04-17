import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/auth/SignInRes.dart';
import '../model/customer/Customer.dart';
import '../model/customer/CustomerResetPasswordReq.dart';
import '../model/customer/CutomerRes.dart';
import '../screen/customer/customer_reset_password.dart';
import '../servies_provider/provider_url.dart';
import '../utils/constant.dart';

class CustomerData {
  Future<CustomerListRes> getCustomerAll() async {
    CustomerListRes res = CustomerListRes();
    String url = ProviderUrl.basicUrlWebApi + ProviderUrl.getCustomerAllUrl;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = CustomerListRes.fromJson(jsonDecode(response.body));
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

  Future<CustomerRes> getCustomerById(id) async {
    CustomerRes res = CustomerRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getCustomerAllByIdUrl +
        id.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = CustomerRes.fromJson(jsonDecode(response.body));
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

  Future<CustomerListRes> getCustomerByPage(int page) async {
    CustomerListRes res = CustomerListRes();
    String url = ProviderUrl.basicUrlWebApi +
        ProviderUrl.getCustomerAllByPageUrl +
        page.toString();
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headerWithToken(getToken()),
    );
    if (response.statusCode == 200) {
      res = CustomerListRes.fromJson(jsonDecode(response.body));
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

  Future<CustomerRes> createCustomer(Customer req) async {
    CustomerRes res = CustomerRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.createCustomerUrl;
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json; charset=UTF-8"},

        ///<===========
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        res = CustomerRes.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<CustomerRes> updateCustomer(Customer req) async {
    CustomerRes res = CustomerRes();
    try {
      String url = ProviderUrl.basicUrlWebApi + ProviderUrl.updateCustomerUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: headerWithToken(getToken()),
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        //res = CurrencyRes.fromJson(jsonDecode(response.body));
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = CustomerRes.fromJson(map);
      }
    } catch (e) {
      throw ("$e");
    }
    return res;
  }

  Future<CustomerRes> changeCustomerPassword(CustomerChangePassReq req) async {
    CustomerRes res = CustomerRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.CustomerChangePasswordUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = CustomerRes.fromJson(map);
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

  Future<CustomerRes> resetCustomerPassword(
      CustomerResetPasswordReq req) async {
    CustomerRes res = CustomerRes();
    try {
      String url =
          ProviderUrl.basicUrlWebApi + ProviderUrl.CustomerResetPasswordUrl;
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(req),
      );
      if (response.statusCode == 200) {
        final Map map = json.decode(utf8.decode(response.bodyBytes));
        res = CustomerRes.fromJson(map);
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
