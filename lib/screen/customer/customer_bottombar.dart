import 'package:aladang_app/screen/customer/customer_order_history.dart';
import 'package:aladang_app/screen/customer/customer_shop_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import 'customer_cart.dart';
import 'customer_cart_screen.dart';
import 'customer_edit_profile.dart';

// ignore: must_be_immutable
class CustomerBottomBar extends StatefulWidget {
  CustomerBottomBar({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  State<CustomerBottomBar> createState() => _CustomerBottomBarState();
}

class _CustomerBottomBarState extends State<CustomerBottomBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    currentIndex = widget.index;
    final tab = [
      const CustomerShopScreen(),
      const CustomerOrderHistory(),
      // const CustomerCartScreen(),
      const CustomerEditProfile(),
    ];

    return Scaffold(
      body: tab[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primary,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.store),
            label: "shop".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: "history".tr(),
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(Icons.add_shopping_cart),
          //   label: "cart".tr(),
          // ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "profile".tr(),
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 22,
        onTap: (index) {
          setState(() {
            widget.index = index;
          });
        },
      ),
    );
  }
}
