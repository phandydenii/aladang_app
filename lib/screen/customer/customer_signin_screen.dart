import 'package:aladang_app/helpdata/customer_data.dart';
import 'package:aladang_app/model/customer/Customer.dart';
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
import '../../utils/constant.dart';
import 'customer_bottombar.dart';
import 'customer_reset_password.dart';
import 'customer_signup_screen.dart';

class CustomerSignInScreen extends StatefulWidget {
  const CustomerSignInScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSignInScreen> createState() => _CustomerSignInScreenState();
}

class _CustomerSignInScreenState extends State<CustomerSignInScreen> {
  static final _keyValidationForm = GlobalKey<FormState>();
  final TextEditingController _txtPhoneNumber = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState() {
    _onLoading();
    isPasswordVisible = false;
    super.initState();
  }

  void _onLoading() {
    setState(() {
      Future.delayed(const Duration(seconds: 0), _login);
    });
  }

  Future _login() async {
    setState(() {});
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
                  'welcome_to_customer'.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   child: const Text(
                //     'Sign in to continue',
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 16),
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
                    //suffixIcon: const Icon(Icons.phone),
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
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
                            style: TextStyle(
                              color: Color.fromRGBO(49, 6, 112, 10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomerSignUpScreen()),
                            );
                          }),
                      TextButton(
                        child: Text(
                          'forgot_password'.tr(),
                          style: TextStyle(
                            color: Color.fromRGBO(49, 6, 112, 10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CustomerResetPassword(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    style: TextStyle(
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
      setState(() {});
      await EasyLoading.show(status: 'loading...');
      SignInReq req = SignInReq();
      Customer customerModel = Customer();
      var sharedPre = await SharedPreferences.getInstance();
      req.phone = _txtPhoneNumber.text;
      req.password = _txtPassword.text;
      req.usertype = "customer";
      req.ostype = "String";
      req.tokenid = "String";
      AuthenticationData().loginUser(req).then((value) async {
        final localStorage = LocalStorage("TOKEN_APP");
        localStorage.setItem("ACCESS_TOKEN", value.toJson());
        var result = await CustomerData().getCustomerById(value.data!.id);
        setCustomerSP(result.data!);
        await EasyLoading.showSuccess('Login Success!',
            duration: const Duration(seconds: 2));
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerBottomBar(
                index: 0,
              ),
            ),
          );
        });
      }).catchError((onError) {
        EasyLoading.showToast(
          'Invalid username or password!',
          duration: const Duration(
            seconds: 5,
          ),
        );
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
}
