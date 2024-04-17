import 'package:aladang_app/model/customer/Customer.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customer_cart.dart';
import 'customer_cart_screen.dart';
import 'customer_edit_profile.dart';
import 'customer_order_history.dart';
import 'customer_shop_screen.dart';

// ignore: must_be_immutable
class HomeScreenCustomer extends StatefulWidget {
  HomeScreenCustomer({Key? key, required this.i}) : super(key: key);
  int i;
  @override
  State<HomeScreenCustomer> createState() => _HomeScreenCustomerState();
}

class _HomeScreenCustomerState extends State<HomeScreenCustomer> {
  final prefs = SharedPreferences.getInstance();
  // ignore: non_constant_identifier_names
  String? customer_name = "";
  int? cusid;
  Customer customer = Customer();

  void getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customer_name = prefs.getString('cus_name');
      cusid = prefs.getInt(CUSTOMER_ID);
      customer.customerName = prefs.getString(CUSTOMER_NAME);
      // ignore: avoid_print
      print(customer.customerName);
    });
  }

  @override
  void initState() {
    getLogin();
    super.initState();
  }

  int currentIndex = 0;
  final _tab = [
    const CustomerShopScreen(),
    const CustomerOrderHistory(),
    const CustomerCartScreen(),
    const CustomerEditProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    currentIndex = widget.i;
    return Scaffold(
      body: _tab[currentIndex],
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
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_shopping_cart),
            label: "cart".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "profile".tr(),
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        selectedFontSize: 14,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),

      // drawer: Drawer(
      //   backgroundColor: primary,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       UserAccountsDrawerHeader(
      //         accountName: Text("${customer.customerName}"),
      //         accountEmail: Text(""),
      //         currentAccountPicture: CircleAvatar(
      //           child: Image.asset("assets/images/dollar.png"),
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.account_circle,
      //           color: Colors.white,
      //         ),
      //         title: Row(
      //           children: [
      //             Text(
      //               "edit_profile".tr(),
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             const Spacer(),
      //             const Icon(
      //               Icons.arrow_right,
      //               color: Colors.white,
      //             ),
      //           ],
      //         ),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => CustomerEditProfile(
      //                 cid: cusid,
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.language,
      //           color: Colors.white,
      //         ),
      //         title: Row(
      //           children: [
      //             Text(
      //               "Language".tr(),
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             const Spacer(),
      //             const Icon(
      //               Icons.arrow_right,
      //               color: Colors.white,
      //             ),
      //           ],
      //         ),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const LanguageScreen(),
      //             ),
      //           ).then((value) {
      //             if (value == "KM") {
      //               context.setLocale(const Locale('km', 'KM'));
      //             }
      //             if (value == "EN") {
      //               context.setLocale(const Locale('en', 'EN'));
      //             }
      //           });
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.notification_add,
      //           color: Colors.white,
      //         ),
      //         title: Row(
      //           children: [
      //             Text(
      //               "Notification".tr(),
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             const Spacer(),
      //             const Icon(
      //               Icons.arrow_right,
      //               color: Colors.white,
      //             ),
      //           ],
      //         ),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const CustomerNotification(),
      //             ),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.logout,
      //           color: Colors.white,
      //         ),
      //         title: Row(
      //           children: [
      //             Text(
      //               "logout".tr(),
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             const Spacer(),
      //             const Icon(
      //               Icons.arrow_right,
      //               color: Colors.white,
      //             ),
      //           ],
      //         ),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const StartScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      // appBar: AppBar(
      //   title: Text("ayukveng".tr()),
      //   backgroundColor: primary,
      // ),
      // body: Center(
      //   child: Column(
      //     children: <Widget>[
      //       Expanded(
      //         flex: 3,
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(
      //             horizontal: 5,
      //             vertical: 5,
      //           ),
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(20), // Image border
      //             child: Image.asset(
      //               "assets/images/shop-6.jpeg",
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         flex: 6,
      //         child: Padding(
      //           padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
      //           child: GridView.builder(
      //             physics: const NeverScrollableScrollPhysics(),
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //               crossAxisSpacing: 0,
      //               mainAxisSpacing: 0,
      //             ),
      //             itemCount: customerMenuList.length,
      //             itemBuilder: (context, index) {
      //               final i = index + 1;
      //               return GestureDetector(
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => CustomerBottomBar(index: i),
      //                     ),
      //                   );
      //                 },
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(15),
      //                   child: Container(
      //                     //padding: const EdgeInsets.symmetric(horizontal: 10),
      //                     alignment: Alignment.center,
      //                     decoration: BoxDecoration(
      //                       border: Border.all(color: primary, width: 2),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Image.asset(
      //                           customerMenuList[index]["image"],
      //                           height: 100,
      //                         ),
      //                         Text(
      //                           "${customerMenuList[index]["name"]}".tr(),
      //                           style: const TextStyle(fontSize: 18),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
