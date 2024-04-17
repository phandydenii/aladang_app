import 'dart:ffi';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonDeisableEnable extends StatefulWidget {
  ButtonDeisableEnable({Key? key,required this.onClick,required this.name,required this.color,required this.enable}) : super(key: key);
  VoidCallback? onClick;
  String? name;
  Color? color;
  Bool? enable;
  @override
  State<ButtonDeisableEnable> createState() => _ButtonDeisableEnableState();
}

class _ButtonDeisableEnableState extends State<ButtonDeisableEnable> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.name ?? "",
              style: const TextStyle(color: Colors.white,fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
