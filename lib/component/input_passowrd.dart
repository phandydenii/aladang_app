import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PassWordInputText extends StatefulWidget {
  const PassWordInputText({
    Key? key,
    this.controller,
    this.fontsize,
    this.prefixIcon,
    this.inputType,
    required this.name,
  }) : super(key: key);
  final TextEditingController? controller;
  final double? fontsize;
  final Icon? prefixIcon;
  final String? name;
  final TextInputType? inputType;
  @override
  State<PassWordInputText> createState() => _PassWordInputTextState();
}

class _PassWordInputTextState extends State<PassWordInputText> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    isPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType ?? TextInputType.text,
      textInputAction: TextInputAction.next,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.name,
        suffixIcon: IconButton(
          icon:
              Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          iconSize: widget.fontsize,
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_enter_your_password'.tr();
        }
        return null;
      },
    );
  }
}
