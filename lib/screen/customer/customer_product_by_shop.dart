import 'package:aladang_app/component/input_text_search.dart';
import 'package:aladang_app/helpdata/exchange_rate_data.dart';
import 'package:aladang_app/model/exchangerate/ExchangeRate.dart';
import 'package:aladang_app/screen/customer/customer_cart.dart';
import 'package:aladang_app/screen/customer/customer_product_detail.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpdata/product_data.dart';
import '../../helper/product_cart_db.dart';
import '../../model/product/Product.dart';

// ignore: must_be_immutable
class CustomerProductByShop extends StatefulWidget {
  CustomerProductByShop({Key? key, required this.shopid}) : super(key: key);
  int? shopid;
  @override
  State<CustomerProductByShop> createState() => _CustomerProductByShopState();
}

class _CustomerProductByShopState extends State<CustomerProductByShop> {
  List<Product> selectedProductOrde = [];

  TextEditingController txtSearch = TextEditingController();
  bool isSearch = false;
  int addToCard = 0;
  List<Product> productActive = [];
  List<Product> resultProduct = [];
  ExchangeRate exchangeRate = ExchangeRate();

  ScrollController scActive = ScrollController();
  int currenPageActive = 1;
  int countActive = 0;

  double exrate = 0;

  void getProductByShopId(shopid, page, status) async {
    var result = await ProductData().getProductByShopId(shopid, page, status);
    setState(() {
      productActive = result.data!;
      currenPageActive = result.count!;
      resultProduct = result.data!;
      currenPageActive++;
    });
  }

  void buildSearch(String txt) {
    setState(() {
      if (txt.isEmpty) {
        productActive = resultProduct;
      } else {
        productActive = resultProduct
            .where((element) =>
                element.productName!.toLowerCase().contains(txt.toLowerCase()))
            .toList();
      }
    });
  }

  void getExchangeRate(shopid) async {
    var result = await ExchangeRateData().getExchangeRateByShopId(shopid);
    var sharedPre = await SharedPreferences.getInstance();
    setState(() {
      exchangeRate = result.data!;
      exrate = result.data!.rate!;
      sharedPre.setDouble("exchange_rate", result.data!.rate!);
      sharedPre.setInt(EXCHANGE_ID, result.data!.id!);
      sharedPre.setDouble(EXCHANGE_RATE, result.data!.rate!);
    });
  }

  @override
  void initState() {
    getExchangeRate(widget.shopid);
    getProductByShopId(widget.shopid, currenPageActive, "Active");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        automaticallyImplyLeading: false,
        title: const Text(
          "Product By Shop",
          style: TextStyle(color: primary),
        ),
        actions: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundColor: primary,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerCart(
                            itemList: selectedProductOrde,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_basket_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "$addToCard",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primary,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InputTextSearch(
              controller: txtSearch,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              name: "Search",
              onChange: (value) {
                buildSearch(value);
                setState(() {
                  if (value.isNotEmpty) {
                    isSearch = !isSearch;
                  } else {
                    isSearch = !isSearch;
                  }
                });
              },
              onPress: () {
                if (txtSearch.text.isNotEmpty) {
                  setState(() {
                    txtSearch.text = "";
                    isSearch = false;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: ListView.builder(
                itemCount: productActive.length,
                itemBuilder: (context, index) {
                  final item = productActive[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerProductDetail(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.asset(
                                          "assets/images/proitem.png"),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          child: Text(
                                            'Product :${item.productName}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          child: Text(
                                            'Price :${item.price}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  addProductCart(
                                    item.id,
                                    item.productCode,
                                    item.productName,
                                    item.price,
                                  );
                                  selectedProductOrde.add(
                                    Product(
                                      id: item.id,
                                      shopId: item.shopId,
                                      productCode: item.productCode,
                                      productName: item.productName,
                                      description: item.description,
                                      qtyInStock: item.qtyInStock,
                                      price: item.price,
                                      currencyId: item.currencyId,
                                      cutStockType: item.cutStockType,
                                      expiredDate: item.expiredDate,
                                      linkVideo: item.linkVideo,
                                      imageThumbnail: item.imageThumbnail,
                                      status: item.status,
                                    ),
                                  );
                                  addToCard++;
                                });
                              },
                              icon: const Icon(
                                Icons.add_shopping_cart,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
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

  // Insert a new data to the database
  Future<void> addProductCart(id, proCode, proName, price) async {
    await ProductCartDB.insertProductCart(id, proCode, proName, price);
  }
}
