// ignore_for_file: constant_identifier_names

import 'package:aladang_app/model/exchangerate/ExchangeRate.dart';
import 'package:aladang_app/model/shop/Shop.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpdata/exchange_rate_data.dart';
import '../helper/product_cart_db.dart';

///=======Font Size=====
const double textSize = 14;
const double textSizeTitle = 16;

Map<String, String> headerWithToken(String token) {
  Map<String, String> map = {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json; charset=UTF-8"
  };
  return map;
}

const primary = Color.fromRGBO(49, 6, 112, 10);
//const primary = Color.fromRGBO(252, 186, 3, 10);
const primaryColor = Colors.pink;

///==========Share Preference Key Shop
const String SHOP_ID = "id";
const String SHOP_NO = "shopid";
const String SHOP_NAME = "shopname";
const String GENDER = "gender";
const String DOB = "dob";
const String NATIONALITY = "nationality";
const String OWNERNAME = "ownername";
const String PHONE = "phone";
const String PASSWORD = "password";
const String TOKEN_ID = "tokenid";
const String FACEBOOK_PAGE = "facebookpage";
const String LOCATION = "location";
const String LOGO_SHOP = "logoshop";
const String PAYMENT_TYPE = "paymenttype";
const String QRCODE_IMAGE = "qrcodeimage";
const String BANK_NAME_ID = "banknameid";
const String ACCOUNT_NUMBER = "accountnumber";
const String ACCOUNT_NAME = "accountname";
const String FEE_TYEPE = "feetype";
const String FEE_CHARGE = "feecharge";
const String SHOP_HISTORY_DATE = "shophistorydate";
const String NOTE = "note";
const String STATUS = "status";
const String ID_CARD = "idcard";
const String EXPIRE_DATE = "expiredate";

///==========Share Preference Key Customer
const String CUSTOMER_ID = "customer_id";
const String CUSTOMER_PHONE = "customer_phone";
const String CUSTOMER_LOCATION = "customer_location";
const String CUSTOMER_NAME = "customer_name";
const String CUSTOMER_GENDER = "customer_gender";
const String CUSTOMER_IMAGE = "customer_image";
const String CUSTOMER_PASSWORD = "customer_password";

////==========Share Preference Key Exchange Rate
const String EXCHANGE_ID = "exchange_id";
const String EXCHANGE_RATE = "exchange_rate";

void truncateProductCart() async {
  await ProductCartDB.truncateProductCart();
}

void setCustomerSP(customerModel) async {
  final SharedPreferences sharedPre = await SharedPreferences.getInstance();
  sharedPre.setInt(CUSTOMER_ID, customerModel.id ?? 0);
  sharedPre.setString(CUSTOMER_NAME, customerModel.customerName ?? "");
  sharedPre.setString(CUSTOMER_LOCATION, customerModel.currentLocation ?? "");
  sharedPre.setString(CUSTOMER_PHONE, customerModel.phone ?? "");
  sharedPre.setString(CUSTOMER_GENDER, customerModel.gender ?? "");
  sharedPre.setString(CUSTOMER_IMAGE, customerModel.imageProfile ?? "");
  sharedPre.setString(CUSTOMER_PASSWORD, customerModel.password ?? "");
}

void setShopSP(item) async {
  final SharedPreferences sharedPre = await SharedPreferences.getInstance();
  sharedPre.setInt(SHOP_ID, item.id ?? 0);
  sharedPre.setString(SHOP_NO, item.shopid ?? "");
  sharedPre.setString(SHOP_NAME, item.shopName ?? "");
  sharedPre.setString(LOCATION, item.location ?? "");
  sharedPre.setString(PHONE, item.phone ?? "");
  sharedPre.setString(PAYMENT_TYPE, item.paymentType ?? "");
  sharedPre.setString(QRCODE_IMAGE, item.qrCodeImage ?? "");
  sharedPre.setInt(BANK_NAME_ID, item.bankNameid ?? 0);
  sharedPre.setString(ACCOUNT_NAME, item.accountName ?? "");
  sharedPre.setString(ACCOUNT_NUMBER, item.accountNumber ?? "");
}

Future<Shop> getShopSP() async {
  Shop shop = Shop();
  final SharedPreferences sp = await SharedPreferences.getInstance();
  shop.id = sp.getInt(SHOP_ID);
  shop.shopid = sp.getString(SHOP_NO);
  shop.shopName = sp.getString(SHOP_NAME);
  shop.phone = sp.getString(PHONE);
  shop.paymentType = sp.getString(PAYMENT_TYPE);
  shop.qrCodeImage = sp.getString(QRCODE_IMAGE);
  shop.bankNameid = sp.getInt(BANK_NAME_ID);
  shop.accountName = sp.getString(ACCOUNT_NAME);
  shop.accountNumber = sp.getString(ACCOUNT_NUMBER);
  shop.location = sp.getString(LOCATION);
  return shop;
}

void setExchageRateSP(id) async {
  var result = await ExchangeRateData().getExchangeRateByShopId(id);
  final SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setInt(EXCHANGE_ID, result.data!.id ?? 0);
  sp.setDouble(EXCHANGE_RATE, result.data!.rate ?? 0);
}

Future<ExchangeRate> getExchageRateSP() async {
  ExchangeRate exchangeRate = ExchangeRate();
  final SharedPreferences sp = await SharedPreferences.getInstance();
  exchangeRate.id = sp.getInt(EXCHANGE_ID);
  exchangeRate.rate = sp.getDouble(EXCHANGE_RATE);
  return exchangeRate;
}
