import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aladang_app/utils/constant.dart';
import '../../helper/product_cart_db.dart';
import '../../model/product/Product.dart';
import 'customer_paid.dart';

class CustomerCartScreen extends StatefulWidget {
  const CustomerCartScreen({Key? key}) : super(key: key);

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  List<Product> productList = [];
  double total = 0;

  bool _isButtonDisabled = true;
  double exrate = 0;
  void getShopSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      exrate = prefs.getDouble("exchange_rate")!;
    });
  }

  List<Map<String, dynamic>> myData = [];
  void _refreshData() async {
    total = 0;
    final data = await ProductCartDB.getProductCartCount();
    setState(() {
      if (data.isNotEmpty) {
        _isButtonDisabled = false;
      }
      myData = data;
      for (var item in data) {
        total = total + (item['price'] * item['count']);
      }
    });
  }

  void truncateProductCart() async {
    await ProductCartDB.truncateProductCart();
  }

  @override
  void initState() {
    _refreshData();
    getShopSharePreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "cart".tr(),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       truncateProductCart();
        //       _refreshData();
        //     },
        //     child: Text("Clear"),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: myData.isEmpty
                ? const Center(
                    child: Text("No data!"),
                  )
                : ListView.builder(
                    itemCount: myData.length,
                    itemBuilder: (context, index) {
                      final item = myData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 0.5,
                              color: primary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${item['productName']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '${item['price']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        deleteProductCart(item['productId']);
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
                        ),
                      );
                    },
                  ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        CardBadge(
                          name: "Total:   \$$total",
                          description: "៛${total * exrate}",
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _isButtonDisabled
                              ? null
                              : () {
                                  //_build(context);
                                  //buildVehicle(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustomerPaid(
                                          //productList: productList,
                                          ),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.green,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: Text("order".tr()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
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
}

class CardBadge extends StatelessWidget {
  const CardBadge({
    Key? key,
    required this.name,
    required this.description,
  }) : super(key: key);
  final String name, description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              // fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              //fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
