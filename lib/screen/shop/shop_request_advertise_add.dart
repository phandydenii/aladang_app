import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShopRequestAdvertiseAdd extends StatefulWidget {
  const ShopRequestAdvertiseAdd({Key? key}) : super(key: key);

  @override
  State<ShopRequestAdvertiseAdd> createState() => _ShopRequestAddState();
}

class _ShopRequestAddState extends State<ShopRequestAdvertiseAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "request".tr(),
          style: const TextStyle(color: primary),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primary,
          ),
        ),
      ),
      body: const Center(
        child: Text("Request"),
      ),
    );
  }
}
