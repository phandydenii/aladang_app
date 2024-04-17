import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../component/button_widget.dart';
import '../../utils/constant.dart';
import '../customer/customer_signin_screen.dart';
import '../language/language_screen.dart';
import '../shop/shop_signin_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final List<String> items = [
    'Khmer',
    'English',
  ];
  String? selectedValue;

  List<Icon> icons = [
    const Icon(Icons.person),
    const Icon(Icons.settings),
    const Icon(Icons.credit_card),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: DropdownButton(
              value: "khmer".tr() == "Khmer" ? "english".tr() : "khmer".tr(),
              iconSize: 0,
              items: [
                //add items in the dropdown
                DropdownMenuItem(
                  value: "khmer".tr(),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/kh.png",
                        width: 35,
                        height: 35,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("khmer".tr()),
                    ],
                  ),
                ),

                DropdownMenuItem(
                  value: "english".tr(),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/en.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("english".tr()),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                value == "Khmer" || value == "ខ្មែរ"
                    ? context.setLocale(const Locale('km', 'KM'))
                    : context.setLocale(const Locale('en', 'EN'));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StartScreen()),
                );
              },
            ),
          )

          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const LanguageScreen(),
          //       ),
          //     ).then((value) {
          //       if (value == "KM") {
          //         context.setLocale(const Locale('km', 'KM'));
          //       }
          //       if (value == "EN") {
          //         context.setLocale(const Locale('en', 'EN'));
          //       }
          //     });
          //   },
          //   icon: Icon(
          //     Icons.language,
          //     color: primary,
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: GestureDetector(
          //     onTap: () {
          //       context.setLocale(const Locale('km', 'KM'));
          //     },
          //     child: Image.asset(
          //       "assets/images/kh.png",
          //       width: 40,
          //       height: 40,
          //     ),
          //   ),
          // )

          // DropdownButtonHideUnderline(
          //   child: DropdownButton2(
          //     customButton: const Icon(
          //       Icons.language,
          //       size: 30,
          //       color: primary,
          //     ),
          //     items: [
          //       ...MenuItems.firstItems.map(
          //         (item) => DropdownMenuItem<MenuItem>(
          //           value: item,
          //           child: MenuItems.buildItem(item),
          //         ),
          //       ),
          //       const DropdownMenuItem<Divider>(
          //           enabled: false, child: Divider()),
          //       ...MenuItems.secondItems.map(
          //         (item) => DropdownMenuItem<MenuItem>(
          //           value: item,
          //           child: MenuItems.buildItem(item),
          //         ),
          //       ),
          //     ],
          //     onChanged: (value) {
          //       MenuItems.onChanged(context, value! as MenuItem);
          //     },
          //     dropdownStyleData: DropdownStyleData(
          //       width: 160,
          //       padding: const EdgeInsets.symmetric(vertical: 6),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(4),
          //         color: primary,
          //       ),
          //       offset: const Offset(0, 8),
          //     ),
          //     menuItemStyleData: MenuItemStyleData(
          //       customHeights: [
          //         ...List<double>.filled(MenuItems.firstItems.length, 48),
          //         8,
          //         ...List<double>.filled(MenuItems.secondItems.length, 48),
          //       ],
          //       padding: const EdgeInsets.only(left: 16, right: 16),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/jsons/business-3.json"),
            //Image.asset("assets/gifs/delivery3.gif"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "who_are_you".tr(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ButtonWidget(
                name: "customer".tr(),
                color: primary,
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerSignInScreen()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ButtonWidget(
                name: "shop".tr(),
                color: primary,
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShopSignInScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [home];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;

      case MenuItems.logout:
        //Do something
        break;
    }
  }
}
