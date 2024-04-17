import 'package:aladang_app/component/button_loading_widget.dart';
import 'package:aladang_app/helpdata/exchange_rate_data.dart';
import 'package:aladang_app/helpdata/shop_data.dart';
import 'package:aladang_app/model/exchangerate/ExchangeRate.dart';
import 'package:aladang_app/screen/shop/shop_home_screen.dart';
import 'package:aladang_app/screen/shop/shop_reset_password.dart';
import 'package:aladang_app/screen/shop/shop_signup_onboarding_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/button_widget.dart';
import '../../component/input_passowrd.dart';
import '../../component/input_text.dart';
import '../../helpdata/auth_data.dart';
import '../../model/auth/SignInReq.dart';
import '../../model/auth/SignInRes.dart';
import '../../model/shop/Shop.dart';
import '../../utils/constant.dart';

class ShopSignInScreen extends StatefulWidget {
  const ShopSignInScreen({Key? key}) : super(key: key);

  @override
  State<ShopSignInScreen> createState() => _ShopSignInScreenState();
}

class _ShopSignInScreenState extends State<ShopSignInScreen> {
  static final _keyValidationForm = GlobalKey<FormState>();
  final TextEditingController _txtPhoneNumber = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    _onLoading();
    isPasswordVisible = false;
    super.initState();
  }

  // @override
  // void dispose() {
  //   FocusScope.of(context).unfocus();
  //   super.dispose();
  // }

  void _onLoading() {
    setState(() {
      _isLoading = true;
      Future.delayed(const Duration(seconds: 0), _login);
    });
  }

  Future _login() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _keyValidationForm,
            child: Column(
              children: [
                Lottie.asset("assets/jsons/business-3.json"),
                Text(
                  'welcome_to_shop'.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   child: const Text(
                //     'Sign in to continue',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 16,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: InputText(
                    controller: _txtPhoneNumber,
                    name: "phone_or_email".tr(),
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: PassWordInputText(
                    controller: _txtPassword,
                    prefixIcon: const Icon(Icons.lock),
                    name: "password".tr(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          child: Text(
                            'sign_up'.tr(),
                            style: const TextStyle(
                              color: Color.fromRGBO(49, 6, 112, 10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShopSignUpOnboardingScreen()),
                            );
                          }),
                      TextButton(
                        child: Text(
                          'forgot_password'.tr(),
                          style: const TextStyle(
                            color: Color.fromRGBO(49, 6, 112, 10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ShopResetPassword()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                _isLoading == true
                    ? const ButtonLoadingWidget()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ButtonWidget(
                          name: 'sign_in'.tr(),
                          onClick: () {
                            login();
                          },
                          color: primary,
                        ),
                      ),
                TextButton(
                  child: Text(
                    'home'.tr(),
                    style: const TextStyle(
                      color: Color.fromRGBO(49, 6, 112, 10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (_keyValidationForm.currentState!.validate()) {
      EasyLoading.show(status: 'loading'.tr());

      var sharedPre = await SharedPreferences.getInstance();
      SignInReq req = SignInReq();
      Shop shopModel = Shop();
      ExchangeRate exchangeRate = ExchangeRate();
      req.phone = _txtPhoneNumber.text;
      req.password = _txtPassword.text;
      req.usertype = "shop";
      req.ostype = "String";
      req.tokenid = "String";
      AuthenticationData().loginUser(req).then((value) async {
        final localStorage = LocalStorage("TOKEN_APP");
        localStorage.setItem("ACCESS_TOKEN", value.toJson());
        var result = await ShopData().getShopById(value.data!.id);
        var ex =
            await ExchangeRateData().getExchangeRateByShopId(value.data!.id);
        setState(() {
          shopModel = result.data!;
          exchangeRate = ex.data!;

          sharedPre.setInt(SHOP_ID, shopModel.id ?? 0);
          sharedPre.setString(SHOP_NO, shopModel.shopid ?? "");
          sharedPre.setString(SHOP_NAME, shopModel.shopName ?? "");
          sharedPre.setString(GENDER, shopModel.gender ?? "");
          sharedPre.setString(DOB, shopModel.dob ?? "");
          sharedPre.setString(NATIONALITY, shopModel.nationality ?? "");
          sharedPre.setString(OWNERNAME, shopModel.ownerName ?? "");
          sharedPre.setString(PHONE, shopModel.phone ?? "");
          sharedPre.setString(PASSWORD, shopModel.password ?? "");
          sharedPre.setString(TOKEN_ID, shopModel.tokenid ?? "");
          sharedPre.setString(LOCATION, shopModel.location ?? "");
          sharedPre.setString(LOGO_SHOP, shopModel.logoShop ?? "");
          sharedPre.setString(PAYMENT_TYPE, shopModel.paymentType ?? "");
          sharedPre.setString(QRCODE_IMAGE, shopModel.qrCodeImage ?? "");
          sharedPre.setInt(BANK_NAME_ID, shopModel.bankNameid ?? 0);
          sharedPre.setString(ACCOUNT_NAME, shopModel.accountName ?? "");
          sharedPre.setString(ACCOUNT_NUMBER, shopModel.accountNumber ?? "");
          sharedPre.setString(FEE_TYEPE, shopModel.feetype ?? "");
          sharedPre.setDouble(FEE_CHARGE, shopModel.feecharge ?? 0);
          sharedPre.setString(
              SHOP_HISTORY_DATE, shopModel.shophistorydate ?? "");
          sharedPre.setString(NOTE, shopModel.note ?? "");
          sharedPre.setString(STATUS, shopModel.status ?? "");
          sharedPre.setString(ID_CARD, shopModel.idcard ?? "");
          sharedPre.setString(EXPIRE_DATE, shopModel.expiredate ?? "");
          sharedPre.setString(FACEBOOK_PAGE, shopModel.facebookPage ?? "");

          sharedPre.setInt(EXCHANGE_ID, exchangeRate.id ?? 0);
          sharedPre.setDouble(EXCHANGE_RATE, exchangeRate.rate ?? 0);
        });

        await EasyLoading.showSuccess('login_successfully'.tr(),
            duration: const Duration(seconds: 2));
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreenShop(),
            ),
          );
        });
      }).catchError((onError) {
        EasyLoading.dismiss();
        showErrorMessage('incorrect_username_password'.tr());
      });
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String getToken() {
    final localStorage = LocalStorage("TOKEN_APP");
    var accessToken = localStorage.getItem("ACCESS_TOKEN");
    SignInRes loginRes = SignInRes.fromJson(accessToken);
    return loginRes.data!.token!;
  }
}
