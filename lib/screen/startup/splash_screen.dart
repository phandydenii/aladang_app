import 'package:aladang_app/screen/startup/start_screen.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final localStorage = LocalStorage("TOKEN_APP");

  @override
  void initState() {
    localStorage;
    Future.delayed(const Duration(seconds: 5), () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => localStorage.getItem("ACCESS_TOKEN") == null
      //         ? const OnBoardingScreen()
      //         : const StartScreen(),
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const StartScreen(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    //       //primaryColor: primary
    //     ),
    //     title: 'ALADANG',
    //     home: AnimatedSplashScreen(
    //       duration: 5000,
    //       splash: Image.asset(
    //         "assets/images/Aladang.png",
    //         height: 1000,
    //         width: 1000,
    //       ),
    //       nextScreen: localStorage.getItem("ACCESS_TOKEN") == null
    //           ? const OnBoardingScreen()
    //           : const StartScreen(),
    //       splashTransition: SplashTransition.fadeTransition,
    //       //backgroundColor: primary,
    //     ),
    //   );
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Image.asset(
            "assets/images/aladang-logo7.png",
            height: 250,
            width: 250,
          ),
        ),
      ),
    );
  }
}
