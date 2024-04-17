import 'package:flutter/material.dart';

import '../utils/constant.dart';

// ignore: must_be_immutable
class InputTextWidget extends StatefulWidget {
  InputTextWidget({
    Key? key,
    required this.name,
    this.icon,
    this.password,
    this.onTap,
    this.controller,
    required this.isDropdown,
  }) : super(key: key);
  TextEditingController? controller;
  String? name;
  IconData? icon;
  bool? password;
  VoidCallback? onTap;
  bool? isDropdown;
  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name!,
            style: const TextStyle(fontSize: 16),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    //readOnly: true,
                    onTap: widget.onTap,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    cursorColor: primary,
                    obscureText: widget.password ?? false,
                    controller: widget.controller,
                    // validator: (val) {
                    //   val == null ? valid = true : valid = false;
                    // },
                    decoration: InputDecoration(
                      hintText: widget.name!,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                widget.isDropdown == true
                    ? Icon(widget.icon)
                    : const Text(
                        "*",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
