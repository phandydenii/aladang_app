import 'package:aladang_app/model/customer/CustomerResetPasswordReq.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';

import '../../component/button_widget.dart';
import '../../component/input_passowrd.dart';
import '../../component/input_text.dart';
import '../../helpdata/customer_data.dart';
import '../../utils/constant.dart';

class CustomerResetPassword extends StatefulWidget {
  const CustomerResetPassword({Key? key}) : super(key: key);

  @override
  State<CustomerResetPassword> createState() => _CustomerResetPasswordState();
}

class _CustomerResetPasswordState extends State<CustomerResetPassword> {
  static final key = GlobalKey<FormState>();
  final TextEditingController txtCustomerName = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  TextEditingController txtNewPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool _loading = false;

  @override
  void initState() {
    _onLoading();
    isPasswordVisible = false;
    super.initState();
  }

  void _onLoading() {
    setState(() {
      _loading = true;
      Future.delayed(const Duration(seconds: 0), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var fontsize = height * 0.03;
    return Scaffold(
      body: _loading
          ? Center(
              child: CupertinoActivityIndicator(
                radius: height * 0.06,
              ),
            )
          : Form(
              key: key,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Lottie.asset("assets/jsons/business-3.json"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'reset_password'.tr(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          controller: txtCustomerName,
                          name: "customer_name".tr(),
                          //suffixIcon: const Icon(Icons.phone),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          controller: txtPhone,
                          name: "phone_or_email".tr(),
                          //suffixIcon: const Icon(Icons.phone),
                          prefixIcon: const Icon(Icons.phone),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: PassWordInputText(
                          controller: txtNewPassword,
                          name: "new_password".tr(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: PassWordInputText(
                          controller: txtConfirmPassword,
                          name: "confirm_password".tr(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ButtonWidget(
                          name: "save".tr(),
                          color: primary,
                          onClick: () {
                            reset();
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              child: Text(
                                'sign_in'.tr(),
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  reset() async {
    if (key.currentState!.validate()) {
      await EasyLoading.show(status: 'loading'.tr());
      if (txtNewPassword.text == txtConfirmPassword.text) {
        try {
          CustomerResetPasswordReq req = CustomerResetPasswordReq();
          req.phone = txtPhone.text;
          req.customerName = txtCustomerName.text;
          req.newPassword = txtNewPassword.text;
          final res = await CustomerData().resetCustomerPassword(req);
          if (res.code == 200) {
            EasyLoading.showSuccess('reset_password_success'.tr(),
                duration: const Duration(seconds: 2));
            Navigator.pop(context, true);
          }
        } catch (e) {
          EasyLoading.dismiss();
          showErrorMessage('not_found'.tr());
        }
      } else {
        EasyLoading.dismiss();
        showErrorMessage('password_not_match'.tr());
      }
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: primary,
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
