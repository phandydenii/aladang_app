import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputText extends StatefulWidget {
  InputText({
    Key? key,
    required this.name,
    this.prefixIcon,
    this.suffixIcon,
    this.password,
    this.onTap,
    this.requred,
    this.textInputType,
    this.controller,
    this.readOnly,
    this.valid,
    this.initialValue,
  }) : super(key: key);
  TextEditingController? controller;
  String? name;
  Icon? prefixIcon;
  Icon? suffixIcon;
  bool? password;
  VoidCallback? onTap;
  bool? requred = false;
  bool? readOnly;
  bool? valid;
  TextInputType? textInputType;
  String? initialValue;
  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: TextFormField(
          // initialValue: widget.initialValue == null ? "" : widget.initialValue,
          readOnly: widget.readOnly == null ? false : true, 
          controller: widget.controller,
          keyboardType: widget.textInputType,
          textInputAction: TextInputAction.next,
          onTap: widget.onTap,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            //widget.requred==true ?
            labelText: widget.name!,
            suffixIcon: widget.suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          ),
          validator: (value) {
            if (value == null ||
                value.isEmpty && widget.valid == null ||
                widget.valid == true) {
              return "${'please_enter'.tr()}${widget.name}";
            }
            return null;
          },
        ),
      ),
    );
  }
}
