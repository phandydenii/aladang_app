import 'package:aladang_app/helpdata/shop_data.dart';
import 'package:aladang_app/model/shop/ResetPassword.dart';
import 'package:aladang_app/screen/shop/shop_signin_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';

import '../../component/button_widget.dart';
import '../../component/input_datetime_widget.dart';
import '../../component/input_passowrd.dart';
import '../../component/input_text.dart';
import '../../utils/constant.dart';

class ShopResetPassword extends StatefulWidget {
  const ShopResetPassword({super.key});

  @override
  State<ShopResetPassword> createState() => _ShopResetPasswordState();
}

class _ShopResetPasswordState extends State<ShopResetPassword> {
  static final key = GlobalKey<FormState>();
  final TextEditingController txtShopName = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtNewPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  final TextEditingController txtShopHistoryDate = TextEditingController();
  final TextEditingController txtExpireDate = TextEditingController();
  final TextEditingController txtIDCard = TextEditingController();

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                Lottie.asset("assets/jsons/business-3.json"),
                // "phone": "09876545",

                Text(
                  'reset_password'.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   child: const Text(
                //     'After you reset password successfully, it will redirect to !',
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
                    controller: txtShopName,
                    name: "shop_name".tr(),
                    //prefixIcon: Icon(Icons.lock),
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
                    //prefixIcon: Icon(Icons.lock),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: InputText(
                    controller: txtIDCard,
                    valid: false,
                    name:
                        "${"card_no".tr()} ${"or".tr()} ${"passport_no".tr()}",
                    //prefixIcon: Icon(Icons.lock),
                  ),
                ),
                // InputDateTimeWidget(
                //   valid: false,
                //   name: "shop_history_date".tr(),
                //   controller: txtShopHistoryDate,
                //   prefixIcon: const Icon(Icons.date_range),
                //   suffixIcon: const Icon(Icons.arrow_drop_down),
                //   vertical: 10,
                //   horizontal: 20,
                // ),
                InputDateTimeWidget(
                  name: "expire_date".tr(),
                  controller: txtExpireDate,
                  prefixIcon: const Icon(Icons.date_range),
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  vertical: 10,
                  horizontal: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: PassWordInputText(
                    controller: txtNewPassword,
                    prefixIcon: const Icon(Icons.lock),
                    name: "new_password".tr(),
                  ),
                ),
                // "password": "09803",
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: PassWordInputText(
                    controller: txtConfirmPassword,
                    prefixIcon: const Icon(Icons.lock),
                    name: "confirm_password".tr(),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ButtonWidget(
                    name: 'reset_password'.tr(),
                    onClick: () {
                      reset();
                    },
                    color: primary,
                  ),
                ),
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
        ),
      ),
    );
  }

  reset() async {
    if (key.currentState!.validate()) {
      EasyLoading.show(status: 'loading'.tr());
      if (txtNewPassword.text == txtConfirmPassword.text) {
        ResetPasswordShop req = ResetPasswordShop();
        req.shopName = txtShopName.text;
        req.phone = txtPhone.text;
        req.idcard = txtIDCard.text;
        req.expiredate = txtExpireDate.text;
        req.newPassword = txtNewPassword.text;
        req.confirmNewPassword = txtConfirmPassword.text;
        ShopData().resetPasswordShop(req).then((value) async {
          await EasyLoading.showSuccess('reset_password_success'.tr(),
              duration: const Duration(seconds: 1));
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }).catchError((onError) {
          showErrorMessage("fail".tr());
        });
      } else {
        EasyLoading.dismiss();
        showErrorMessage("password_not_match".tr());
      }
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
