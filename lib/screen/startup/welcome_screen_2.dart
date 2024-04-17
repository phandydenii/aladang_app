import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreenSecond extends StatefulWidget {
  const WelcomeScreenSecond({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenSecond> createState() => _WelcomeScreenSecondState();
}

class _WelcomeScreenSecondState extends State<WelcomeScreenSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/jsons/business-2.json"),
      ),
    );
  }
}
