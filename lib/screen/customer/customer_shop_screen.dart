import 'package:aladang_app/screen/customer/customer_shop_detail.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/input_text_search.dart';
import '../../helpdata/exchange_rate_data.dart';
import '../../helpdata/shop_data.dart';
import '../../helper/product_cart_db.dart';
import '../../model/exchangerate/ExchangeRate.dart';
import '../../model/shop/Shop.dart';

class CustomerShopScreen extends StatefulWidget {
  const CustomerShopScreen({Key? key}) : super(key: key);

  @override
  State<CustomerShopScreen> createState() => _CustomerShopScreenState();
}

class _CustomerShopScreenState extends State<CustomerShopScreen> {
  TextEditingController txtSearch = TextEditingController();
  List<Shop> shopList = [];
  List<Shop> shopReslut = [];
  List<Shop> shopSearch = [];
  bool _isLoading = false;
  ScrollController sc = ScrollController();
  int page = 1;
  int? shopid;
  int? countAll;
  int? totalPage = 0;
  bool isSearch = false;

  void getShopListAll() async {
    var result = await ShopData().getShopListAll();
    setState(() {
      shopSearch = result.data!;
    });
  }

  void getShopList(page) async {
    _isLoading = true;
    var result = await ShopData().getShopList(page);
    setState(() {
      shopList = shopList + result.data!;
      shopReslut = result.data!;
      _isLoading = false;
      totalPage = result.countPage;
      countAll = result.count;
    });
  }

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
  void initState() {
    getShopList(page);
    super.initState();
    getShopListAll();
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        page++;
        if (page <= totalPage!) {
          getShopList(page);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
                name: "Search shop here!",
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
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              crossAxisCount: 2,
                              childAspectRatio: width / 475,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final item = shopList[index];
                              return GestureDetector(
                                onTap: () async {
                                  truncateProductCart();
                                  setShopSP(item);
                                  // setExchageRateSP(item.id);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustomerShopDetail(
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
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          width: width * 0.4,
                                                          height: height * 0.17,
                                                          child: const Center(
                                                            child:
                                                                Text("No Logo"),
                                                          ),
                                                        )
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          width: width * 0.4,
                                                          height: height * 0.15,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              ProviderUrl
                                                                      .getImageUrlApi +
                                                                  item.logoShop!,
                                                              height: 110,
                                                              width: 110,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
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
    );
  }
}
