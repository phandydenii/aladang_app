import 'package:aladang_app/component/button_widget.dart';
import 'package:aladang_app/component/input_passowrd.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/input_text.dart';
import '../../helpdata/customer_data.dart';
import '../../model/customer/Customer.dart';

class CustomerChangePassword extends StatefulWidget {
  const CustomerChangePassword({Key? key}) : super(key: key);

  @override
  State<CustomerChangePassword> createState() => _CustomerChangePasswordState();
}

class _CustomerChangePasswordState extends State<CustomerChangePassword> {
  TextEditingController txtCustomerName = TextEditingController();
  static final _keyValidationForm = GlobalKey<FormState>();
  TextEditingController currenPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Customer customerSp = Customer();
  void getLogint() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerSp.customerName = prefs.getString(CUSTOMER_NAME);
      customerSp.id = prefs.getInt(CUSTOMER_ID);
      customerSp.phone = prefs.getString(CUSTOMER_PHONE);
      print(customerSp.id);
    });
  }

  @override
  void initState() {
    getLogint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Chnage Passord",
          style: TextStyle(color: primary),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyValidationForm,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: PassWordInputText(
                  controller: currenPassword,
                  name: "Curren Password",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: PassWordInputText(
                  controller: newPassword,
                  name: "New Password",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: PassWordInputText(
                  controller: confirmPassword,
                  name: "Confirm Password",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ButtonWidget(
                  name: "Save",
                  color: primary,
                  onClick: () {
                    update();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  update() async {
    if (_keyValidationForm.currentState!.validate()) {
      await EasyLoading.show(status: 'loading...');
      if (newPassword.text == confirmPassword.text) {
        try {
          CustomerChangePassReq req = CustomerChangePassReq();
          req.userId = customerSp.id;
          req.currentPassword = currenPassword.text;
          req.newPassword = newPassword.text;
          final res = await CustomerData().changeCustomerPassword(req);
          if (res.code == 200) {
            EasyLoading.showSuccess('Login Success!',
                duration: const Duration(seconds: 2));
            Navigator.pop(context, true);
          }
        } catch (e) {
          EasyLoading.dismiss();
          showErrorMessage('Invalid current password!');
        }
      } else {
        EasyLoading.dismiss();
        showErrorMessage('Your password not match!');
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
