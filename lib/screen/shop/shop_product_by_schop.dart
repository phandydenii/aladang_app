import 'package:aladang_app/utils/constant.dart';
import 'package:flutter/material.dart';

import '../../component/input_text.dart';
import '../../helpdata/product_data.dart';
import '../../model/product/Product.dart';

class ShopProductByShop extends StatefulWidget {
 const ShopProductByShop({Key? key, required this.shopId}) : super(key: key);
 final int? shopId;
  @override
  State<ShopProductByShop> createState() => _ShopProductByShopState();
}

class _ShopProductByShopState extends State<ShopProductByShop> {
  TextEditingController txtSearch = TextEditingController();
  bool? isSearch = false;

  List<Product> productActive = [];

  ScrollController scActive = ScrollController();
  int currenPageActive = 1;
  int countActive = 0;

  void getProductByShopId(shopid, page, status) async {
    var result = await ProductData().getProductByShopId(shopid, page, status);
    setState(() {
      productActive = result.data!;
      currenPageActive = result.count!;
      currenPageActive++;
    });
  }

  @override
  void initState() {
    getProductByShopId(widget.shopId, currenPageActive, "Active");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        title: Text("Product Each Shop ${productActive.length}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: InputText(
              controller: txtSearch,
              name: "Search",
              suffixIcon: const Icon(Icons.search),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: productActive.isEmpty
                  ? const Center(
                      child: Text(
                        "No Product!",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : GridView.builder(
                      itemCount: productActive.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            children: [
                              Image.asset("assets/images/2.png"),
                              const Text("Produc")
                            ],
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
// SizedBox(
//   height: 250,
//   child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: productAll.length,
//     itemBuilder: (context, index) {
//       final item = productAll[index];
//       return GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ShopProductByShop(
//                 shopId: null,
//               ),
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//                 boxShadow: const [
//                   BoxShadow(
//                     spreadRadius: 1,
//                     blurRadius: 6,
//                     color: Colors.grey,
//                   )
//                 ]),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10)),
//                     child: Image.asset(
//                       'assets/images/hotel-1.jpg',
//                       width: 300,
//                       //height: 100,
//                     ),
//                   ),
//                   Positioned(
//                     top: 5,
//                     left: 5,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             BorderRadius.circular(20),
//                         color: primary,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(5),
//                         child: Text(
//                           "\$${item.price}",
//                           style: const TextStyle(
//                               fontSize: 18,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 5,
//                     right: 5,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             BorderRadius.circular(20),
//                         color: primary,
//                       ),
//                       child: IconButton(
//                         icon: const Icon(Icons.shop),
//                         onPressed: () {},
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ]),
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Product Code: ${item.productCode}",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         'Product Name : ${item.productName}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   ),
// ),
