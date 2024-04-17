import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InputDateTimeWidget extends StatefulWidget {
  const InputDateTimeWidget({
    Key? key,
    required this.name,
    this.prefixIcon,
    this.suffixIcon,
    required this.vertical,
    required this.horizontal,
    this.controller,
    this.valid,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? name;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final double? horizontal;
  final double? vertical;
  final bool? valid;
  @override
  State<InputDateTimeWidget> createState() => _InputDateTimeWidgetState();
}

class _InputDateTimeWidgetState extends State<InputDateTimeWidget> {
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontal!, vertical: widget.vertical!),
      child: TextFormField( 
        controller: widget.controller,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            setState(() {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              widget.controller?.text = formattedDate;
              FocusScope.of(context).unfocus();
            });
          }
        },
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: widget.name,
          suffixIcon: widget.suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        validator: (value) {
          if (value == null ||
              value.isEmpty && widget.valid == null ||
              widget.valid == true) {
            return 'Please enter ${widget.name}.';
          }
          return null;
        },
      ),
    );
  }
}
