import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomScreeThird extends StatefulWidget {
  const WelcomScreeThird({Key? key}) : super(key: key);

  @override
  State<WelcomScreeThird> createState() => _WelcomScreeThirdState();
}

class _WelcomScreeThirdState extends State<WelcomScreeThird> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/jsons/business-3.json"),
      ),
    );
  }
}
