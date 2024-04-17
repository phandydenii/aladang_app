import 'package:flutter/material.dart';

import '../../helpdata/product_data.dart';
import '../../model/product/Product.dart';

class CustomerShopDetailScreen extends StatefulWidget {
  const CustomerShopDetailScreen({Key? key}) : super(key: key);

  @override
  State<CustomerShopDetailScreen> createState() =>
      _CustomerShopDetailScreenState();
}

class _CustomerShopDetailScreenState extends State<CustomerShopDetailScreen> {
  ScrollController scAll = ScrollController();
  List<Product> productAll = [];
  int page = 1;
  void getProductList(page) async {
    var result = await ProductData().getProductList(page);
    setState(() {
      productAll = result.data!;
    });
  }

  @override
  void initState() {
    getProductList(page);
    scAll.addListener(() {
      if (scAll.position.pixels == scAll.position.maxScrollExtent) {
        getProductList(page);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/images/2.png",
            height: 100,
          ),
          const Text("Hello"),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   isExtended: true,
      //   backgroundColor: primary,
      //   label: Icon(Icons.arrow_back_ios),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
//
// ListView.builder(
// itemCount: productAll.length,
// itemBuilder: (context, index) {
// final item = productAll[index];
// return GestureDetector(
// onTap: () {},
// child: Padding(
// padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
// child: GestureDetector(
// onTap: () {},
// child: Card(
// color: Colors.white,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "No: ${item.productCode}",
// style: const TextStyle(
// fontSize: 16,
// color: Colors.black,
// ),
// ),
// Text(
// "Name: ${item.productName}",
// style: const TextStyle(
// fontSize: 16,
// color: Colors.black,
// ),
// ),
// Text(
// "Qty: ${item.qtyInStock}",
// style: const TextStyle(
// fontSize: 16,
// color: Colors.black,
// ),
// ),
// Text(
// "Price: ${item.price}",
// style: const TextStyle(
// fontSize: 16,
// color: Colors.black,
// ),
// ),
// Text(
// "${item.status}",
// style: const TextStyle(
// fontSize: 16,
// color: Colors.red,
// fontWeight: FontWeight.bold),
// ),
// ],
// ),
// ),
// ],
// ),
// Column(
// children: [
// Padding(
// padding: const EdgeInsets.all(10),
// child: Image.asset(
// "assets/images/2.png",
// height: 100,
// ),
// )
// ],
// ),
// ],
// ),
// ),
// ),
// ),
// );
// },
// controller: scAll,
// )
