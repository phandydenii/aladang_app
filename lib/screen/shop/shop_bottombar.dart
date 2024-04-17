import 'package:aladang_app/screen/shop/shop_order_history.dart';
import 'package:aladang_app/screen/shop/shop_payme.dart';
import 'package:aladang_app/screen/shop/shop_product_screen.dart';
import 'package:aladang_app/screen/shop/shop_report_screen.dart';
import 'package:aladang_app/screen/shop/shop_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/constant.dart';
import 'shop_request_advertise.dart';

// ignore: must_be_immutable
class ShopBottomBar extends StatefulWidget {
  ShopBottomBar({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  State<ShopBottomBar> createState() => _ShopBottomBarState();
}

class _ShopBottomBarState extends State<ShopBottomBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    currentIndex = widget.index;
    final tab = [
      const Center(child: Text("Home")),
      const ShopOrderHistory(),
      const ShopAll(),
      const ShopProductScreen(),
      const ShopRequestAdvertise(),
      const ShopPayMe(isSetting: false),
      const ShopReport(),
    ];
    return Scaffold(
      body: tab[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primary,

        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: 'order'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.store),
            label: 'shop'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag),
            label: 'product'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.remove_from_queue_rounded),
            label: 'request'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.qrcode_viewfinder),
            label: 'payme'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.news),
            label: 'report'.tr(),
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        // showUnselectedLabels: false,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 18,
        onTap: (index) {
          setState(() {
            widget.index = index;
            if (index == 0) {
              Navigator.pop(context);
            }
          });
        },
      ),
    );
  }
}
