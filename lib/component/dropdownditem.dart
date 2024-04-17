
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownItem extends StatefulWidget {
  DropDownItem({Key? key,required this.selectedItem,required this.dropdownMenuItems}) : super(key: key);
  List selectedItem=[];
  List<DropdownMenuItem> dropdownMenuItems = [];
  ValueChanged? onChange;
  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              isExpanded: true,
              iconEnabledColor: Colors.blue,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
              value: widget.selectedItem,
              items: widget.dropdownMenuItems,
              onChanged: widget.onChange,
            ),
          ),
        ),
      ),
    );
  }
}
