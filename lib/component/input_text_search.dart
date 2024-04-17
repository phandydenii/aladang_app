import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextSearch extends StatefulWidget {
  InputTextSearch({
    Key? key,
    required this.name,
    this.prefixIcon,
    this.onChange,
    this.textInputType,
    this.controller,
    this.onPress,
    this.sufixIcon,
  }) : super(key: key);
  TextEditingController? controller;
  String? name;
  Icon? prefixIcon;
  Icon? sufixIcon;
  Function(String)? onChange;
  VoidCallback? onPress;
  TextInputType? textInputType;
  @override
  State<InputTextSearch> createState() => _InputTextSearchState();
}

class _InputTextSearchState extends State<InputTextSearch> {
  @override
  Widget build(BuildContext context) {
    // return TextFormField(
    //   controller: widget.controller,
    //   keyboardType: widget.textInputType,
    //   textInputAction: TextInputAction.next,
    //   onChanged: widget.onChange,
    //   style: const TextStyle(
    //     color: Colors.black,
    //     backgroundColor: Colors.white,
    //   ),
    //   decoration: InputDecoration(
    //     filled: true,
    //
    //     fillColor: Colors.white,
    //     prefixIcon: widget.prefixIcon,
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     //widget.requred==true ?
    //     //labelText: widget.name,
    //     hintText: widget.name,
    //     suffixIcon: widget.suffixIcon,
    //     contentPadding:
    //         const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    //   ),
    //   validator: (value) {
    //     if (value == null || value.isEmpty) {
    //       return 'Please enter ${widget.name}.';
    //     }
    //     return null;
    //   },
    // );
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              width: 250,
              child: TextFormField(  
                controller: widget.controller,
                keyboardType: widget.textInputType,
                textInputAction: TextInputAction.next,
                onChanged: widget.onChange,

                style: const TextStyle(
                  color: Colors.black,
                ),
                //onChanged: ,
                decoration: InputDecoration(
                  hintText: widget.name,
                  border: InputBorder.none,
                  prefixIcon: widget.prefixIcon,
                ),
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     //color: primary,
          //     borderRadius: BorderRadius.only(
          //       bottomRight: Radius.circular(15),
          //       topRight: Radius.circular(15),
          //     ),
          //   ),
          //   child: IconButton(
          //     onPressed: widget.onPress,
          //     icon: widget.sufixIcon!,
          //   ),
          // ),
        ],
      ),
    );
  }
}
