import 'package:flutter/material.dart';

import '../utils/constant.dart';

class ButtonLoadingWidget extends StatefulWidget {
  const ButtonLoadingWidget({Key? key}) : super(key: key);

  @override
  State<ButtonLoadingWidget> createState() => _ButtonLoadingWidgetState();
}

class _ButtonLoadingWidgetState extends State<ButtonLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
