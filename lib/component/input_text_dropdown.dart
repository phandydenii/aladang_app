import 'package:flutter/material.dart';

class InputTextDropdown extends StatefulWidget {
 const InputTextDropdown({
    Key? key,
    this.icon,
    this.prefixicon
  }) : super(key: key);
  final IconData? icon;
 final Icon? prefixicon;
  @override
  State<InputTextDropdown> createState() => _InputTextDropdownState();
}

class _InputTextDropdownState extends State<InputTextDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "select date",
                  border: InputBorder.none,
                  prefixIcon: widget.prefixicon,
                ),
              ),
            ),
            const Spacer(),
            Icon(widget.icon as IconData)
          ],
        ),
      ),
    );
  }
}
