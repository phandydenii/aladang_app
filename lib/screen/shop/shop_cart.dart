import 'package:aladang_app/class/product_cart_view.dart';
import 'package:aladang_app/screen/shop/shop_check_out.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/product_cart_db.dart';
import '../../model/product/Product.dart';
import '../../model/shop/Shop.dart';

// ignore: must_be_immutable
class ShopCartScreen extends StatefulWidget {
  ShopCartScreen({super.key, required this.itemList, this.shop});
  List<Product> itemList = [];
  final Shop? shop;
  @override
  State<ShopCartScreen> createState() => _ShopCartScreenState();
}

class OrderItem {
  int? id;
  String? name;
  OrderItem({this.id, this.name});
}

class _ShopCartScreenState extends State<ShopCartScreen> {
  List<Product> orderProductList = [];
  List<Product> orderProList = [];
  List<ProductCardView> proCart = [];

  List<String> items = [];
  List<OrderItem> orderItems = [];

  double total = 0;
  bool _isButtonDisabled = true;

  List<Map<String, dynamic>> myData = [];
  void _refreshData() async {
    total = 0;
    final data = await ProductCartDB.getProductCartCount();
    setState(() {
      if (data.isNotEmpty) {
        _isButtonDisabled = false;
      }
      //total = sumTotal;
      myData = data;
      for (var item in data) {
        total = total + (item['price'] * item['count']);
      }
    });
  }

  @override
  void initState() {
    _refreshData();
    if (widget.itemList.isNotEmpty) {
      _isButtonDisabled = false;
    }
    super.initState();
  }

  List<int> ind = [];
  int count = 1;

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        //backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "cart".tr(),
        ),
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: myData.isEmpty
                ? const Center(
                    child: Text("Please go back to choose item!"),
                  )
                : ListView.builder(
                    itemCount: myData.length,
                    itemBuilder: (context, index) {
                      final item = myData[index];
                      return Column(
                        children: [
                          Card(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item['productName']}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '\$${item['price']}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        deleteProductCart(item['id']);
                                      },
                                      icon: const Icon(CupertinoIcons.minus),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item['count']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        addProductCart(
                                          item['productId'],
                                          item['productCode'],
                                          item['productName'],
                                          item['price'],
                                        );
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
          Expanded(
            child: Container(
              color: primary,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Qty",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              "\$$total",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.check_outlined),
                              onPressed: _isButtonDisabled
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ShopCheckOutProduct(
                                            productList: orderProductList,
                                            shop: widget.shop,
                                          ),
                                        ),
                                      );
                                    },
                              label: const Text('Check Out'),
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: Colors.green,
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteProductCart(id) async {
    await ProductCartDB.delete(id);
    _refreshData();
  }

  Future<void> addProductCart(
      int id, String proCode, String proName, double price) async {
    total = total + price;
    await ProductCartDB.insertProductCart(id, proCode, proName, price);
    _refreshData();
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: primary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
