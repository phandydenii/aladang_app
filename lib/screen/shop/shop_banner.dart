import 'package:aladang_app/helpdata/banner_data.dart';
import 'package:aladang_app/screen/shop/shop_banner_add.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../model/banner/Banner.dart';

class ShopBanner extends StatefulWidget {
  const ShopBanner({Key? key}) : super(key: key);

  @override
  State<ShopBanner> createState() => _ShopBannerState();
}

class _ShopBannerState extends State<ShopBanner> {
  List<BannerReq> bannerList = [];
  bool isLoading = false;

  void getBannerList() async {
    isLoading = true;
    var result = await BannerData().getBannerAll();
    setState(() {
      bannerList = result.data!;
      // EasyLoading.dismiss();
      isLoading = false;
    });
  }

  @override
  void initState() {
    // EasyLoading.show(status: 'loading...');
    getBannerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "${"setting".tr()} ${"banner".tr()}",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopBannerAddScreen(
                    banner: null,
                  ),
                ),
              ).then(
                (value) {
                  if (value == true) {
                    setState(() {
                      getBannerList();
                    });
                  }
                },
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : bannerList.isEmpty
              ? const Center(
                  child: Text("No Data!"),
                )
              : ListView.builder(
                  //scrollDirection: Axis.vertical,
                  itemCount: bannerList.length,
                  itemBuilder: (context, i) {
                    final item = bannerList[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopBannerAddScreen(
                                banner: item,
                              ),
                            ),
                          ).then(
                            (value) {
                              if (value == true) {
                                setState(() {
                                  getBannerList();
                                });
                              }
                            },
                          );
                        },
                        child: Card(
                          elevation: 1,
                          color: Colors.white,
                          child: isLoading == true
                              ? const Center(child: CircularProgressIndicator())
                              : Stack(
                                  children: [
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: item.bannerimage != ""
                                                ? Image.network(
                                                    ProviderUrl.getImageUrlApi +
                                                        item.bannerimage!,
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    "assets/images/no_img.jpg",
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green[300],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Text(
                                            "${DateFormat('yyyy-MM-dd').format(DateTime.parse(item.date!))}",
                                            style: TextStyle(
                                                fontSize: textSize,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
