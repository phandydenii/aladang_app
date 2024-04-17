import 'package:aladang_app/helpdata/customer_data.dart';
import 'package:aladang_app/screen/customer/customer_signin_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';

import '../../component/button_widget.dart';
import '../../component/input_passowrd.dart';
import '../../component/input_text.dart';
import '../../model/customer/Customer.dart';
import '../../utils/constant.dart';

class CustomerSignUpScreen extends StatefulWidget {
  const CustomerSignUpScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSignUpScreen> createState() => _CustomerSignUpScreenState();
}

class _CustomerSignUpScreenState extends State<CustomerSignUpScreen> {
  static final key = GlobalKey<FormState>();
  final TextEditingController txtCustomerName = TextEditingController();
  final TextEditingController txtGender = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtLocation = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
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
    final height = MediaQuery.of(context).size.height;
    var fontsize = height * 0.03;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                Lottie.asset("assets/jsons/business-3.json"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'customer_register'.tr(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   child: const Text(
                //     'Sign up to continue',
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
                    controller: txtCustomerName,
                    name: "customer_name".tr(),
                    //icon: const Icon(Icons.phone),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: InputText(
                    controller: txtGender,
                    name: "gender".tr(),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    //isDropdown: false,
                    onTap: () {
                      buildGender(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: InputText(
                    controller: txtLocation,
                    name: "address".tr(),
                    //icon: const Icon(Icons.phone),
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
                    //icon: const Icon(Icons.phone),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: PassWordInputText(
                    controller: txtPassword,
                    prefixIcon: const Icon(Icons.lock),
                    name: "password".tr(),
                  ),
                ),
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
                    name: "sign_up".tr(),
                    color: primary,
                    onClick: () {
                      create();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        child: Text(
                          'sign_in'.tr(),
                          style: const TextStyle(
                            color: Color.fromRGBO(49, 6, 112, 10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  create() async {
    if (key.currentState!.validate()) {
      if (txtPassword.text == txtConfirmPassword.text) {
        await EasyLoading.show(status: 'loading...');
        Customer req = Customer();
        req.id = 0;
        req.date = "2023-09-18T16:48:08.018Z";
        req.customerName = txtCustomerName.text;
        req.gender = txtGender.text;
        req.phone = txtPhone.text;
        req.currentLocation = txtLocation.text;
        req.tokenid = "";
        req.imageProfile = "";
        req.password = txtPassword.text;

        CustomerData().createCustomer(req).then((value) async {
          await EasyLoading.showSuccess('Register Success!',
              duration: const Duration(seconds: 2));
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }).catchError((onError) {
          EasyLoading.showToast(
            'Invalid username or password!',
            duration: const Duration(
              seconds: 5,
            ),
          );
          setState(() {});
        });
      }
    }
  }

  String? selectedSex;
  List genderList = ['male'.tr(), 'female'.tr()];
  void buildGender(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            setState(() {
              FocusScope.of(context).unfocus();
            });
          },
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: DraggableScrollableSheet(
              initialChildSize: 0.23,
              minChildSize: 0.2,
              maxChildSize: 0.75,
              builder: (_, controller) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      //====== header =====
                      Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                        ),
                        child: Center(
                            child: Text("gender".tr(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: controller,
                          itemCount: genderList.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedSex = genderList[index];
                                  txtGender.text = "$selectedSex";
                                  // yearExpanded = !yearExpanded;
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      // color: Colors.brown,
                                      child: Center(
                                        child: Text(
                                          "${genderList[index]}",
                                          style: const TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                        thickness: 0.5,
                                        height: 0,
                                        color: Colors.grey.shade300),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
