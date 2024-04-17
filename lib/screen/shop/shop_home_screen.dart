import 'package:aladang_app/screen/shop/shop_banner.dart';
import 'package:aladang_app/screen/shop/shop_bottombar.dart';
import 'package:aladang_app/screen/shop/shop_currency_type.dart';
import 'package:aladang_app/screen/shop/shop_exchange_rate.dart';
import 'package:aladang_app/screen/shop/shop_payme.dart';
import 'package:aladang_app/screen/shop/shop_profile.dart';
import 'package:aladang_app/screen/shop/shop_notification.dart';
import 'package:aladang_app/screen/shop/shop_privacy.dart';
import 'package:aladang_app/screen/shop/shop_request_advertise.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpdata/shop_data.dart';
import '../../model/shop/Shop.dart';
import '../../servies_provider/provider_url.dart';
import '../../utils/data.dart';
import '../language/language_screen.dart';
import '../startup/start_screen.dart';

class HomeScreenShop extends StatefulWidget {
  const HomeScreenShop({Key? key}) : super(key: key);

  @override
  State<HomeScreenShop> createState() => _HomeScreenShopState();
}

class _HomeScreenShopState extends State<HomeScreenShop> {
  int? shopid;
  String? shopname;
  void getShopSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopid = prefs.getInt(SHOP_ID);
      getShopById(shopid);
      print(shopid);
    });
  }

  Shop shopsp = Shop();
  bool _isLoading = false;
  void getShopById(id) async {
    _isLoading = true;
    var result = await ShopData().getShopById(id);
    setState(() {
      shopsp = result.data!;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getShopSharePreference();

    super.initState();
  }

  Widget imageExists(String url) {
    try {
      return Image.network(
        url,
        height: 110,
        width: 110,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.camera_alt,
              ),
            ),
          );
        },
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: primary),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            width: 80,
                            height: 80,
                            child: _isLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: imageExists(
                                        ProviderUrl.getImageUrlApi +
                                            shopsp.logoShop!)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${shopsp.shopName}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${shopsp.phone}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopProfile(),
                            ),
                          ).then(
                            (value) {
                              if (value == true) {
                                setState(() {
                                  getShopById(shopid);
                                });
                              }
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.account_circle,
                                color: primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "edit_profile".tr(),
                                  style: const TextStyle(
                                    color: primary,
                                    fontSize: textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 0.5,
                        height: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopExchangeRate(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.currency_exchange,
                                color: primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'exchange'.tr(),
                                  style: const TextStyle(
                                    color: primary,
                                    fontSize: textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 0.5,
                        height: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopCurrencyType(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.monetization_on_outlined,
                                color: primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "currency".tr(),
                                  style: const TextStyle(
                                    color: primary,
                                    fontSize: textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 0.5,
                        height: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopRequestAdvertise(
                                isSetting: true,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.remove_from_queue_sharp,
                                color: primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "request".tr(),
                                  style: const TextStyle(
                                    color: primary,
                                    fontSize: textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 0.5,
                        height: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopPayMe(
                                isSetting: true,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.qrcode_viewfinder,
                                color: primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "payme".tr(),
                                  style: const TextStyle(
                                    color: primary,
                                    fontSize: textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 0.5,
                        height: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopBanner(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_activity,
                                color: primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "banner".tr(),
                                  style: const TextStyle(
                                    color: primary,
                                    fontSize: textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 0.5,
                        height: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopPrivacy(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.privacy_tip_outlined,
                                color: primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "privacy".tr(),
                                  style: const TextStyle(
                                    color: primary,
                                    fontSize: textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 0.5,
                        height: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StartScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                color: primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "logout".tr(),
                                  style: const TextStyle(
                                    color: primary,
                                    fontSize: textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expanded(
            //   flex: 8,
            //   child: ListView(
            //     padding: EdgeInsets.zero,
            //     children: [
            //       UserAccountsDrawerHeader(
            //         accountName: Text("${shopsp.shopName}"),
            //         accountEmail: Text("${shopsp.location}"),
            //         currentAccountPicture: CircleAvatar(
            //           child: _isLoading == true
            //               ? const Center(child: CircularProgressIndicator())
            //               : shopsp.logoShop == null || shopsp.logoShop == ""
            //                   ? Image.asset("assets/images/add-image.png")
            //                   : Image.network(
            //                       ProviderUrl.getImageUrlApi + shopsp.logoShop!,
            //                       fit: BoxFit.cover,
            //                     ),
            //         ),
            //       ),
            //       ListTile(
            //         leading: const Icon(
            //           Icons.account_circle,
            //           color: Colors.white,
            //           size: 20,
            //         ),
            //         title: Row(
            //           children: [
            //             Text(
            //               "edit_profile".tr(),
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: textSize,
            //               ),
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
            //               builder: (context) => ShopProfile(
            //                 shopid: shopid,
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //       ListTile(
            //         leading: const Icon(
            //           Icons.currency_exchange,
            //           color: Colors.white,
            //         ),
            //         title: Row(
            //           children: [
            //             Text(
            //               'exchange'.tr(),
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: textSize,
            //               ),
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
            //               builder: (context) => const ShopExchangeRate(),
            //             ),
            //           );
            //         },
            //       ),
            //       ListTile(
            //         leading: const Icon(
            //           Icons.monetization_on_outlined,
            //           color: Colors.white,
            //         ),
            //         title: Row(
            //           children: [
            //             Text(
            //               'currency'.tr(),
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: textSize,
            //               ),
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
            //               builder: (context) => const ShopCurrencyType(),
            //             ),
            //           );
            //         },
            //       ),
            //       ListTile(
            //         leading: const Icon(
            //           Icons.remove_from_queue_sharp,
            //           color: Colors.white,
            //         ),
            //         title: Row(
            //           children: [
            //             Text(
            //               'request'.tr(),
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: textSize,
            //               ),
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
            //               builder: (context) => const ShopRequestAdvertise(
            //                 isSetting: true,
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10, right: 10),
            //         child: Divider(
            //           thickness: 0.5,
            //           height: 0,
            //           color: Colors.grey.shade300,
            //         ),
            //       ),
            //       ListTile(
            //         leading: const Icon(
            //           CupertinoIcons.qrcode_viewfinder,
            //           color: Colors.white,
            //         ),
            //         title: Row(
            //           children: [
            //             Text(
            //               'payme'.tr(),
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: textSize,
            //               ),
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
            //               builder: (context) => const ShopPayMe(
            //                 isSetting: true,
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10, right: 10),
            //         child: Divider(
            //           thickness: 0.5,
            //           height: 0,
            //           color: Colors.grey.shade300,
            //         ),
            //       ),
            //       ListTile(
            //         leading: const Icon(
            //           Icons.local_activity,
            //           color: Colors.white,
            //         ),
            //         title: Row(
            //           children: [
            //             Text(
            //               'banner'.tr(),
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: textSize,
            //               ),
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
            //               builder: (context) => const ShopBanner(),
            //             ),
            //           );
            //         },
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10, right: 10),
            //         child: Divider(
            //           thickness: 0.5,
            //           height: 0,
            //           color: Colors.grey.shade300,
            //         ),
            //       ),
            //       ListTile(
            //         leading: const Icon(
            //           Icons.privacy_tip_outlined,
            //           color: Colors.white,
            //         ),
            //         title: Row(
            //           children: [
            //             Text(
            //               "privacy".tr(),
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: textSize,
            //               ),
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
            //               builder: (context) => const ShopPrivacy(),
            //             ),
            //           );
            //         },
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10, right: 10),
            //         child: Divider(
            //           thickness: 0.5,
            //           height: 0,
            //           color: Colors.grey.shade300,
            //         ),
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
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: textSize,
            //               ),
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
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10, right: 10),
            //         child: Divider(
            //           thickness: 0.5,
            //           height: 0,
            //           color: Colors.grey.shade300,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            const Expanded(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "@Version 1.0.1",
                        style: TextStyle(
                          color: primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text(
          "${shopsp.shopName}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: primary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopNotification(),
                ),
              );
            },
            icon: const Icon(
              Icons.notification_add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageScreen(),
                ),
              ).then((value) {
                if (value == "KM") {
                  context.setLocale(const Locale('km', 'KM'));
                }
                if (value == "EN") {
                  context.setLocale(const Locale('en', 'EN'));
                }
              });
            },
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Expanded(
            //   flex: 2,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 5,
            //       vertical: 5,
            //     ),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20), // Image border
            //       child: shopsp.logoShop != null || shopsp.logoShop != ""
            //           ? Container(
            //               decoration: BoxDecoration(
            //                 // color: Colors.grey,
            //                 borderRadius: BorderRadius.circular(
            //                   10,
            //                 ),
            //                 // border: Border.all(
            //                 //   width: 2,
            //                 //   color: Colors.white,
            //                 // ),
            //               ),
            //               width: double.infinity,
            //               height: height * 0.35,
            //               child: _isLoading == true
            //                   ? const Center(child: CircularProgressIndicator())
            //                   : ClipRRect(
            //                       //borderRadius: BorderRadius.circular(10),
            //                       child: Image.network(
            //                         ProviderUrl.getImageUrlApi +
            //                             shopsp.logoShop!,
            //                         fit: BoxFit.cover,
            //                       ),
            //                     ),
            //             )
            //           : Container(
            //               width: double.infinity,
            //               height: height * 0.35,
            //               decoration: BoxDecoration(
            //                 color: Colors.green,
            //                 borderRadius: BorderRadius.circular(
            //                   10,
            //                 ),
            //                 // border: Border.all(
            //                 //   width: 2,
            //                 //   color: primary,
            //                 // ),
            //               ),
            //               child: Center(
            //                 child: Icon(
            //                   Icons.camera_alt_outlined,
            //                   color: Colors.grey[400],
            //                   size: 30,
            //                 ),
            //               ),
            //             ),
            //     ),
            //   ),
            // ),
            Expanded(
              //flex: 6,
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.1,
                  right: width * 0.1,
                  top: height * 0.05,
                ),
                // child: GridView.builder(
                //   physics: const NeverScrollableScrollPhysics(),
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 0,
                //     mainAxisSpacing: 0,
                //   ),
                //   itemCount: shopMenuList.length,
                //   itemBuilder: (context, index) {
                //     final i = index + 1;
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => ShopBottomBar(index: i),
                //           ),
                //         );
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.all(15),
                //         child: Container(
                //           //padding: const EdgeInsets.symmetric(horizontal: 10),
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //             border: Border.all(color: primary, width: 2),
                //             borderRadius: BorderRadius.circular(15),
                //           ),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Image.asset(
                //                 shopMenuList[index]["image"],
                //                 height: height * .1,
                //                 //width: width * .1,
                //               ),
                //               Text(
                //                 shopMenuList[index]["name".tr()],
                //                 style: TextStyle(fontSize: height * 0.02),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                child: GridView.count(
                  primary: false,
                  // padding: const EdgeInsets.all(20),
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  // crossAxisCount: 2,
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopBottomBar(index: 1),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/order1.png",
                                height: height * .1,
                                //width: width * .1,
                              ),
                              Text(
                                "order".tr(),
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopBottomBar(index: 2),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/shop1.png",
                                height: height * .1,
                                //width: width * .1,
                              ),
                              Text(
                                "shop".tr(),
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopBottomBar(index: 3),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/product1.png",
                                height: height * .1,
                                //width: width * .1,
                              ),
                              Text(
                                "product".tr(),
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopBottomBar(index: 4),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/request.png",
                                height: height * .1,
                                //width: width * .1,
                              ),
                              Text(
                                "request".tr(),
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopBottomBar(index: 5),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/qr.png",
                                height: height * .1,
                                //width: width * .1,
                              ),
                              Text(
                                "payme".tr(),
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopBottomBar(index: 6),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/report1.png",
                                height: height * .1,
                                //width: width * .1,
                              ),
                              Text(
                                "report".tr(),
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
