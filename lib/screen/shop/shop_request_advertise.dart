import 'package:aladang_app/screen/shop/shop_request_advertise_add.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShopRequestAdvertise extends StatefulWidget {
  const ShopRequestAdvertise({Key? key, this.isSetting}) : super(key: key);
  final bool? isSetting;
  @override
  State<ShopRequestAdvertise> createState() => _ShopRequestAdvertiseState();
}

class _ShopRequestAdvertiseState extends State<ShopRequestAdvertise> {
  @override
  Widget build(BuildContext context) {
    //CustomImageCropController controller = CustomImageCropController();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: widget.isSetting == true ? true : false,
        title: Text(
          "request".tr() + "advertise".tr(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopRequestAdvertiseAdd(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "No Data!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
