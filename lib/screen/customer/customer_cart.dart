import 'package:aladang_app/component/button_widget.dart';
import 'package:aladang_app/helper/product_cart_db.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/input_text.dart';
import '../../model/product/Product.dart';
import 'customer_paid.dart';

// ignore: must_be_immutable
class CustomerCart extends StatefulWidget {
  CustomerCart({Key? key, required this.itemList}) : super(key: key);
  List<Product> itemList = [];
  @override
  State<CustomerCart> createState() => _CustomerCartState();
}

class _CustomerCartState extends State<CustomerCart> {
  TextEditingController txtDeliveryType = TextEditingController();
  TextEditingController txtLocation = TextEditingController();
  TextEditingController txtPaymentType = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAmountToPaid = TextEditingController();

  List<Product> productList = [];
  double total = 0;

  bool _isButtonDisabled = true;
  double exrate = 0;
  void getShopSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      exrate = prefs.getDouble(EXCHANGE_RATE)!;
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

  @override
  void initState() {
    _refreshData();
    getShopSharePreference();
    productList = widget.itemList;
    if (widget.itemList.isNotEmpty) {
      _isButtonDisabled = false;
    }
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
          style: const TextStyle(color: primary),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primary,
          ),
        ),
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
                          onPressed: () {
                            truncateProductCart();
                            _refreshData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: Text("clear".tr()),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _isButtonDisabled
                              ? null
                              : () {
                                  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CustomerPaid( 
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

// Insert a new data to the database
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

  void buildVehicle(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            setState(() {
              FocusScope.of(context).unfocus();
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
            ),
            child: Column(
              children: [
                //====== header =====
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Order Information",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: InputText(
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            name: "Delivery Type",
                            //controller: test,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: InputText(
                            name: "Location",
                            // controller: test,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: InputText(
                            name: "Phone Number",
                            //controller: test,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: InputText(
                            name: "Payment Type",
                            //controller: test,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: InputText(
                            name: "Amount to paid",
                            //controller: test,
                          ),
                        ),
                        ButtonWidget(
                          name: "Order Now",
                          color: primary,
                          onClick: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
