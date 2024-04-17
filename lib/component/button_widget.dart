import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ButtonWidget extends StatefulWidget {
  ButtonWidget(
      {Key? key,
      required this.name,
      required this.color,
      this.icon,
      required this.onClick})
      : super(key: key);
  VoidCallback? onClick;
  String? name;
  Color? color;
  IconData? icon;
  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.name ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
