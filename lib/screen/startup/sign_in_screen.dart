import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../component/button_loading_widget.dart';
import '../../component/button_widget.dart';
import '../../component/input_passowrd.dart';
import '../../component/input_text.dart';
import '../../utils/constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static final _keyValidationForm = GlobalKey<FormState>();
  final TextEditingController _txtPhoneNumber = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _keyValidationForm,
            child: Column(
              children: [
                Lottie.asset("assets/jsons/business-3.json"),
                const Text(
                  'Welcome Shop',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign in to continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: InputText(
                    controller: _txtPhoneNumber,
                    name: "Phone Number",
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: PassWordInputText(
                    controller: _txtPassword,
                    prefixIcon: const Icon(Icons.lock),
                    name: "Passowrd",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color.fromRGBO(49, 6, 112, 10),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //       const ShopSignUpOnboardingScreen()),
                          // );
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color.fromRGBO(49, 6, 112, 10),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const ShopResetPassword()),
                          // );
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
                          name: 'Sign In',
                          onClick: () {
                            //login();
                          },
                          color: primary,
                        ),
                      ),
                TextButton(
                  child: const Text(
                    'Sign in as other?',
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
}
