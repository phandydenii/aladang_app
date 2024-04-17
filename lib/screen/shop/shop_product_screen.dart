import 'package:aladang_app/helpdata/product_data.dart';
import 'package:aladang_app/screen/shop/shop_product_add.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/input_text_search.dart';
import '../../model/product/Product.dart';
import '../../utils/constant.dart';

class ShopProductScreen extends StatefulWidget {
  const ShopProductScreen({Key? key}) : super(key: key);

  @override
  State<ShopProductScreen> createState() => _ShopProductScreenState();
}

class _ShopProductScreenState extends State<ShopProductScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController txtSearch = TextEditingController();
  int? shopid;
  List<Product> productSearch = [];
  List<Product> productResult = [];

  List<Product> productAll = [];
  List<Product> productActive = [];
  List<Product> productExpire = [];
  List<Product> productOutOfStock = [];
  List<Product> productDelete = [];

  bool _isLoading = false;
  ScrollController scAll = ScrollController();
  ScrollController scActive = ScrollController();
  ScrollController scExpire = ScrollController();
  ScrollController scOutOfStock = ScrollController();
  ScrollController scDelete = ScrollController();

  int currenPageAll = 1;
  int currenPageActive = 1;
  int currenPageExpire = 1;
  int currenPageOutOfStock = 1;
  int currenPageDelete = 1;

  int countAll = 0;
  int countActive = 0;
  int countExpire = 0;
  int countOutOfStock = 0;
  int countDelete = 0;

  ScrollController sc = ScrollController();
  int page = 1;

  bool isSearch = false;
  void buildSearch(String txt) {
    setState(() {
      if (txt.isEmpty) {
        productAll = productResult;
      } else {
        countActive = 0;
        countExpire = 0;
        countOutOfStock = 0;
        countDelete = 0;
        productActive = [];
        productExpire = [];
        productOutOfStock = [];
        productDelete = [];
        productAll = productSearch
            .where((element) =>
                element.productName!.toLowerCase().contains(txt.toLowerCase()))
            .toList();
      }
    });
  }

  void getProductAll() async {
    _isLoading = true;
    var result = await ProductData().getProductAll();
    setState(() {
      productSearch =
          result.data!.where((element) => element.shopId! == shopid).toList();
    });
  }

  void getProductList(page) async {
    _isLoading = true;
    var result = await ProductData().getProductList(page);
    setState(() {
      productAll = result.data!;
      countAll = result.count!;
      currenPageAll++;
      _isLoading = false;
    });
  }

  void getProductByShopId(shopid, page, status) async {
    _isLoading = true;
    var result = await ProductData().getProductByShopId(shopid, page, status);
    setState(() {
      if (status == "Active") {
        productActive = productActive + result.data!;
        countActive = result.count!;
        currenPageActive++;
      } else if (status == "Expire") {
        productExpire = productExpire + result.data!;
        countExpire = result.count!;
        currenPageExpire++;
      } else if (status == "OutOfStock") {
        productOutOfStock = productOutOfStock + result.data!;
        countOutOfStock = result.count!;
        currenPageOutOfStock++;
      } else if (status == "Delete") {
        productDelete = productDelete + result.data!;
        countDelete = result.count!;
        currenPageDelete++;
      } else if (status == "all") {
        productAll = productAll + result.data!;
        productResult = productResult + result.data!;
        countAll = result.count!;
        currenPageAll++;
        _isLoading = false;
      }
      _isLoading = false;
    });
  }

  void scroll() {
    scAll.addListener(() {
      if (scAll.position.pixels == scAll.position.maxScrollExtent) {
        getProductByShopId(shopid, currenPageActive, "all");
      }
    });
    scActive.addListener(() {
      if (scActive.position.pixels == scActive.position.maxScrollExtent) {
        getProductByShopId(shopid, currenPageActive, "Active");
      }
    });
    scExpire.addListener(() {
      if (scExpire.position.pixels == scExpire.position.maxScrollExtent) {
        getProductByShopId(shopid, currenPageExpire, "Expire");
      }
    });
    scOutOfStock.addListener(() {
      if (scOutOfStock.position.pixels ==
          scOutOfStock.position.maxScrollExtent) {
        getProductByShopId(shopid, currenPageOutOfStock, "OutOfStock");
      }
    });
    scDelete.addListener(() {
      if (scDelete.position.pixels == scDelete.position.maxScrollExtent) {
        getProductByShopId(shopid, currenPageDelete, "Delete");
      }
    });
  }

  @override
  void initState() {
    getProductAll();
    getLogint();
    scroll();
    super.initState();
  }

  void getLogint() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopid = prefs.getInt(SHOP_ID);
      if (shopid != null) {
        getProductByShopId(shopid, currenPageActive, "all");
        getProductByShopId(prefs.getInt(SHOP_ID), currenPageActive, "Active");
        getProductByShopId(prefs.getInt(SHOP_ID), currenPageExpire, "Expire");
        getProductByShopId(
            prefs.getInt(SHOP_ID), currenPageOutOfStock, "OutOfStock");
        getProductByShopId(prefs.getInt(SHOP_ID), currenPageDelete, "Delete");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                txtSearch.text = "";
                setState(() {
                  if (txtSearch.text.isEmpty) {
                    productAll = productResult;
                  }
                  isSearch = !isSearch;
                });
              },
              icon: Icon(
                isSearch == false ? Icons.search : Icons.close,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopProductAddScreen(
                      proid: null,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      currenPageAll = 1;
                      currenPageActive = 1;
                      currenPageExpire = 1;
                      currenPageOutOfStock = 1;
                      currenPageDelete = 1;

                      productActive = [];
                      productExpire = [];
                      productOutOfStock = [];
                      productDelete = [];
                      productAll = [];
                      getProductAll();
                      getLogint();
                    }
                  },
                );
              },
              icon: const Icon(Icons.add),
            )
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.8),
            indicatorColor: Colors.green,

            // indicator: UnderlineTabIndicator(
            //   borderSide: BorderSide(width: 5.0),
            //   insets: EdgeInsets.symmetric(horizontal: 16.0),
            // ),
            onTap: (selectedIndex) {},
            tabs: [
              Tab(
                // text: "All ${productAll.length}",
                child: Text(
                  "${"all".tr()} ${productAll.length}",
                  style: const TextStyle(fontSize: textSize),
                ),
              ),
              Tab(
                // text: "Active $countActive",
                child: Text(
                  "${"active".tr()} $countActive",
                  style: const TextStyle(fontSize: textSize),
                ),
              ),
              Tab(
                //text: "Expire $countExpire",
                child: Text(
                  "${"expire".tr()} $countExpire",
                  style: const TextStyle(fontSize: textSize),
                ),
              ),
              Tab(
                // text: "Out Of Stock $countOutOfStock",
                child: Text(
                  "${"out_of_stock".tr()} $countOutOfStock",
                  style: const TextStyle(fontSize: textSize),
                ),
              ),
              Tab(
                //text: "Delete $countDelete",
                child: Text(
                  "${"delete".tr()} $countDelete",
                  style: const TextStyle(fontSize: textSize),
                ),
              ),
            ],
          ),
          title: isSearch == false
              ? Text(
                  "product".tr(),
                  style: const TextStyle(fontSize: textSizeTitle),
                )
              : InputTextSearch(
                  controller: txtSearch,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  name: "Search product here!",
                  onChange: (value) {
                    buildSearch(value);
                  },
                ),
          backgroundColor: primary,
        ),
        body: TabBarView(
          children: [
            ///All Product
            _buildProduct(productAll, scAll),
            _buildProduct(productActive, scActive),
            _buildProduct(productExpire, scExpire),
            _buildProduct(productOutOfStock, scOutOfStock),
            _buildProduct(productDelete, scDelete),
          ],
        ),
      ),
    );
  }

  Center _buildProduct(itemList, sc) {
    return Center(
      child: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
              color: primary,
            ))
          : itemList.isEmpty
              ? const Center(
                  child: Text("No data!"),
                )
              : ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopProductAddScreen(
                              proid: item.id,
                            ),
                          ),
                        ).then(
                          (value) {
                            if (value == true) {
                              currenPageAll = 1;
                              currenPageActive = 1;
                              currenPageExpire = 1;
                              currenPageOutOfStock = 1;
                              currenPageDelete = 1;

                              productActive = [];
                              productExpire = [];
                              productOutOfStock = [];
                              productDelete = [];
                              productAll = [];
                              getLogint();
                              getProductAll();
                            }
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "No: ${item.productCode}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                            //color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Name: ${item.productName}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                            //color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Qty: ${item.qtyInStock}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                            //color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Price: ${item.price}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                            //color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "${item.status}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                            color: Colors.red,
                                            //fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: item.imageThumbnail == null ||
                                            item.imageThumbnail == ""
                                        ? Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.grey[400],
                                                size: 30,
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Image.network(
                                                ProviderUrl.getImageUrlApi +
                                                    item.imageThumbnail,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  controller: sc,
                ),
    );
  }

  // Future<void> _refresh() async {
  //   setState(() {
  //     getProductList(1);
  //   });
  // }
}
