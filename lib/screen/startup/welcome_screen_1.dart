import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreenFirst extends StatefulWidget {
  const WelcomeScreenFirst({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenFirst> createState() => _WelcomeScreenFirstState();
}

class _WelcomeScreenFirstState extends State<WelcomeScreenFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/jsons/business-1.json"),
      ),
    );
  }
}
