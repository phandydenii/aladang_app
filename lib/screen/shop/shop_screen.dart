import 'package:aladang_app/component/input_text_search.dart';
import 'package:aladang_app/helpdata/shop_data.dart';
import 'package:aladang_app/screen/shop/shop_shop_detail.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../helper/product_cart_db.dart';
import '../../model/shop/Shop.dart';

class ShopAll extends StatefulWidget {
  const ShopAll({Key? key}) : super(key: key);

  @override
  State<ShopAll> createState() => _ShopAllState();
}

class _ShopAllState extends State<ShopAll> {
  TextEditingController txtSearch = TextEditingController();
  List<Shop> shopList = [];
  List<Shop> shopReslut = [];
  List<Shop> shopSearch = [];
  bool _isLoading = false;
  ScrollController sc = ScrollController();
  int page = 1;
  int? shopid;
  int? countAll;
  bool isAll = false;
  int? totalPage = 0;
  void getOtherShopListAll() async {
    var result = await ShopData().getShopListAll();
    setState(() {
      shopSearch = result.data!;
    });
  }

  void getOtherShopList(id, page) async {
    _isLoading = true;
    var result = await ShopData().getOtherShopList(id, page);
    setState(() {
      shopList = shopList + result.data!;
      totalPage = result.countPage;
      shopReslut = shopReslut + result.data!;
      _isLoading = false;
      countAll = result.count;
    });
  }

  void getSP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopid = prefs.getInt(SHOP_ID);
      if (shopid != null) {
        getOtherShopList(shopid, page);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getOtherShopListAll();
    getSP();
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        page++;
        if (page <= totalPage!) {
          getOtherShopList(shopid, page);
        }
      }
    });
  }

  bool isSearch = false;
  void buildSearch(String txt) {
    setState(() {
      if (txt.isEmpty) {
        shopList = shopReslut;
      } else {
        shopList = shopSearch
            .where((element) =>
                element.shopName!.toLowerCase().contains(txt.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "shop".tr(),
          style: const TextStyle(color: primary),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              txtSearch.text.isEmpty;
              setState(() {
                if (txtSearch.text.isEmpty) {
                  shopList = shopReslut;
                }
                isSearch = !isSearch;
              });
            },
            icon: Icon(
              isSearch == false ? Icons.search : Icons.close,
              color: primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (isSearch == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InputTextSearch(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                name: "search_shop_here".tr(),
                onChange: (value) {
                  buildSearch(value);
                  //change = true;
                },
              ),
            ),
          Expanded(
            child: _isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: shopList.isEmpty
                        ? const Center(
                            child: Text("No data!"),
                          )
                        : GridView.builder(
                            controller: sc,
                            padding: EdgeInsets.zero,
                            //shrinkWrap: true,
                            itemCount: shopList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final item = shopList[index];
                              return GestureDetector(
                                onTap: () async {
                                  truncateProductCart();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShopShopDetailScreen(
                                        shop: item,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: .3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                  child: item.logoShop!
                                                              .isEmpty ||
                                                          item.logoShop == null
                                                      ? Image.asset(
                                                          "assets/images/no_img.jpg",
                                                          height: 110,
                                                          width: 110,
                                                        )
                                                      : imageExists(ProviderUrl
                                                              .getImageUrlApi +
                                                          item.logoShop!),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${item.shopName!.length > 15 ? '${item.shopName!.substring(0, 15)}...' : item.shopName}",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${item.location!.length > 25 ? '${item.location!.substring(0, 25)}...' : item.location}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
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
                            },
                          ),
                  ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<void> truncateProductCart() async {
    await ProductCartDB.truncateProductCart();
  }

  Widget imageExists(String url) {
    try {
      return Image.network(
        url,
        height: 110,
        width: 110,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 50,
                color: Colors.black54,
              ),
            ),
          );
        },
      );
    } catch (e) {
      return const SizedBox();
    }
  }
}
