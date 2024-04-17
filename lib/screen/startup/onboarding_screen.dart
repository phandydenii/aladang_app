import 'package:aladang_app/screen/startup/start_screen.dart';
import 'package:aladang_app/screen/startup/welcome_screen_1.dart';
import 'package:aladang_app/screen/startup/welcome_screen_2.dart';
import 'package:aladang_app/screen/startup/welcome_screen_3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              WelcomeScreenFirst(),
              WelcomeScreenSecond(),
              WelcomScreeThird(),
            ],
          ),
          Container(
            alignment: const AlignmentDirectional(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const Text("Skip"),
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),
                onLastPage
                    ? GestureDetector(
                  child: const Text("Done"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartScreen(),
                      ),
                    );
                  },
                )
                    : GestureDetector(
                  child: const Text("Next"),
                  onTap: () {
                    _controller.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeIn);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



