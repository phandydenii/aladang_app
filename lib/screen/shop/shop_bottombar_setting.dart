import 'package:aladang_app/screen/shop/shop_banner.dart';
import 'package:aladang_app/screen/shop/shop_currency_type.dart';
import 'package:aladang_app/screen/shop/shop_exchange_rate.dart';
import 'package:aladang_app/screen/shop/shop_payme.dart';
import 'package:aladang_app/screen/shop/shop_request_advertise.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constant.dart';

// ignore: must_be_immutable
class ShopBottomBarSetting extends StatefulWidget {
  ShopBottomBarSetting({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  State<ShopBottomBarSetting> createState() => _ShopBottomBarSettingState();
}

class _ShopBottomBarSettingState extends State<ShopBottomBarSetting> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    currentIndex = widget.index;
    final tab = [
      const Center(child: Text("Home")),
      const ShopExchangeRate(),
      const ShopCurrencyType(),
      const ShopRequestAdvertise(),
      const ShopPayMe(isSetting: true),
      const ShopBanner(),
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
            icon: const Icon(Icons.currency_exchange),
            label: 'exchange'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.monetization_on_outlined),
            label: 'currency'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.remove_from_queue_sharp),
            label: 'request'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.qrcode_viewfinder),
            label: 'payme'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_activity),
            label: 'banner'.tr(),
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        selectedFontSize: 12,
        iconSize: 22,
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
