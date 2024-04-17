import 'package:aladang_app/model/shop/Shop.dart';
import 'package:aladang_app/screen/shop/shop_cart.dart';
import 'package:aladang_app/screen/shop/shop_product_detail.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../component/input_text_search.dart';
import '../../helpdata/product_data.dart';
import '../../helper/product_cart_db.dart';
import '../../model/product/Product.dart';
import '../customer/customer_cart_screen.dart';

class ShopShopDetailScreen extends StatefulWidget {
  const ShopShopDetailScreen({Key? key, required this.shop}) : super(key: key);
  final Shop? shop;
  @override
  State<ShopShopDetailScreen> createState() => _ShopShopDetailScreenState();
}

class _ShopShopDetailScreenState extends State<ShopShopDetailScreen> {
  final CarouselController controller = CarouselController();
  TextEditingController isChecekC = TextEditingController();
  bool _isLoading = false;
  List<Product> productAll = [];
  List<Product> productResult = [];
  List<Product> productActive = [];
  List<Product> productExpire = [];
  List<Product> productOutOfStock = [];
  List<Product> productDelete = [];

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

  int currentIndex = 0;
  int page = 1;
  int addToCard = 0;

  List<String> itemList = [];
  List<Product> selectedProductOrde = [];

  final List<Map<String, dynamic>> selected = [];

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
        productAll = result.data!;
        countAll = result.count!;
        currenPageAll++;
      }
      _isLoading = false;
    });
  }

  void getProductAll() async {
    _isLoading = true;
    var result = await ProductData().getProductAll();
    setState(() {
      productResult = result.data!;
    });
  }

  void buildSearch(String txt) {
    setState(() {
      if (txt.isEmpty) {
        productAll = productResult;
      } else {
        productAll = productResult
            .where((element) =>
                element.productName!.toLowerCase().contains(txt.toLowerCase()))
            .toList();
      }
    });
  }

  Widget imageExists(String url) {
    try {
      return Image.network(
        url,
        height: 110,
        width: 110,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Center(child: const Text("Logo not found!")),
          );
        },
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  @override
  void initState() {
    getProductAll();
    getProductByShopId(widget.shop?.id, currenPageAll, "all");
    getProductByShopId(widget.shop?.id, currenPageActive, "Active");
    getProductByShopId(widget.shop?.id, currenPageExpire, "Expire");
    getProductByShopId(widget.shop?.id, currenPageOutOfStock, "OutOfStock");
    getProductByShopId(widget.shop?.id, currenPageDelete, "Delete");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primary,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopCartScreen(
                            itemList: selectedProductOrde,
                            shop: widget.shop,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
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
      ),
      body: Column(
        children: [
          imageExists(ProviderUrl.getImageUrlApi + widget.shop!.logoShop!),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.shop?.shopName}",
                      style: const TextStyle(
                        color: primary,
                        fontSize: textSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Location: ${widget.shop?.location}",
                      style: const TextStyle(
                        color: primary,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Tell: ${widget.shop?.phone}",
                      style: const TextStyle(
                        color: primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: InputTextSearch(
              //controller: txtSearch,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              name: "Search shop here!",
              onChange: (value) {
                buildSearch(value);
              },
            ),
          ),
          Expanded(
            flex: 6,
            child: _isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : productAll.isEmpty
                    ? const Center(
                        child: Text("No Data!"),
                      )
                    : ListView.builder(
                        itemCount: productAll.length,
                        itemBuilder: (context, index) {
                          final item = productAll[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: _isLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => ShopProductDetail(),
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: .1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              item.imageThumbnail!.isEmpty ||
                                                      item.imageThumbnail ==
                                                          null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10,
                                                          ),
                                                        ),
                                                        height: 110,
                                                        width: 110,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons
                                                                .camera_alt_outlined,
                                                            color: Colors
                                                                .grey[400],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        5,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          ProviderUrl
                                                                  .getImageUrlApi +
                                                              item.imageThumbnail!,
                                                          height: 110,
                                                          width: 110,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              "${item.productName}"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              "${item.description}"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: primary,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Text(
                                                                "\$${item.price}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child:
                                                                  item.qtyInStock ==
                                                                          0
                                                                      ? Text(
                                                                          "${item.qtyInStock}",
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.red,
                                                                              fontWeight: FontWeight.bold),
                                                                        )
                                                                      : Text(
                                                                          "${item.qtyInStock}",
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: primary,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons
                                                                .add_shopping_cart,
                                                            color: primary,
                                                          ),
                                                          onPressed:
                                                              item.qtyInStock ==
                                                                      0
                                                                  ? () {
                                                                      showErrorMessage(
                                                                          "Sorry! Product out of stock!");
                                                                    }
                                                                  : () {
                                                                      setState(
                                                                          () {
                                                                        addProductCart(
                                                                          item.id,
                                                                          item.productCode,
                                                                          item.productName,
                                                                          item.price,
                                                                        );
                                                                        selectedProductOrde
                                                                            .add(
                                                                          Product(
                                                                            id: item.id,
                                                                            shopId:
                                                                                item.shopId,
                                                                            productCode:
                                                                                item.productCode,
                                                                            productName:
                                                                                item.productName,
                                                                            description:
                                                                                item.description,
                                                                            qtyInStock:
                                                                                item.qtyInStock,
                                                                            price:
                                                                                item.price,
                                                                            currencyId:
                                                                                item.currencyId,
                                                                            cutStockType:
                                                                                item.cutStockType,
                                                                            expiredDate:
                                                                                item.expiredDate,
                                                                            linkVideo:
                                                                                item.linkVideo,
                                                                            imageThumbnail:
                                                                                item.imageThumbnail,
                                                                            status:
                                                                                item.status,
                                                                          ),
                                                                        );
                                                                        addToCard++;
                                                                      });
                                                                    },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
          )
        ],
      ),
    );

    // return Scaffold(
    //   body: _isLoading == true
    //       ? const Center(
    //           child: CircularProgressIndicator(),
    //         )
    //       : CustomScrollView(
    //           slivers: [
    //             SliverAppBar(
    //               leading: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Container(
    //                   decoration: const BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     color: primary,
    //                   ),
    //                   child: IconButton(
    //                     icon: const Icon(Icons.arrow_back_ios_new),
    //                     color: Colors.white,
    //                     onPressed: () {
    //                       Navigator.pop(context);
    //                     },
    //                   ),
    //                 ),
    //               ),
    //               actions: [
    //                 Stack(
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Container(
    //                         decoration: const BoxDecoration(
    //                           shape: BoxShape.circle,
    //                           color: primary,
    //                         ),
    //                         child: IconButton(
    //                           icon: const Icon(Icons.add_shopping_cart),
    //                           color: Colors.white,
    //                           onPressed: () {
    //                             Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                 builder: (context) => ShopCartScreen(
    //                                   itemList: selectedProductOrde,
    //                                 ),
    //                               ),
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                     ),
    //                     Positioned(
    //                       right: 4,
    //                       child: Container(
    //                         decoration: const BoxDecoration(
    //                           shape: BoxShape.circle,
    //                           //borderRadius: BorderRadius.circular(10),
    //                           color: Colors.green,
    //                         ),
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(7),
    //                           child: Text(
    //                             "$addToCard",
    //                             style: const TextStyle(color: Colors.white),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //               automaticallyImplyLeading: false,
    //               //backgroundColor: Colors.white,
    //               expandedHeight: height / 4.7,
    //               floating: true,
    //               pinned: true,
    //               flexibleSpace: FlexibleSpaceBar(
    //                 background: Image.asset(
    //                   "assets/images/hotel-1.jpg",
    //                   // width: double.infinity,
    //                   // height: double.infinity,
    //                 ),
    //                 // title: Container(
    //                 //   decoration: BoxDecoration(
    //                 //     color: primary,
    //                 //   ),
    //                 //   child: Text("${widget.shop?.shopName}"),
    //                 // ),
    //               ),
    //             ),
    //             SliverToBoxAdapter(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.all(15),
    //                     child: Text(
    //                       "${widget.shop?.shopName}",
    //                       style: const TextStyle(
    //                         color: primary,
    //                         fontSize: 24,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 15),
    //                     child: InputTextSearch(
    //                       //controller: txtSearch,
    //                       prefixIcon: const Icon(
    //                         Icons.search,
    //                         color: Colors.black,
    //                       ),
    //                       name: "Search shop here!",
    //                       onChange: (value) {
    //                         buildSearch(value);
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             SliverList.builder(
    //               itemCount: productAll.length,
    //               itemBuilder: (context, index) {
    //                 final item = productAll[index];
    //                 return Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: 15, vertical: 5),
    //                   child: _isLoading == true
    //                       ? const Center(
    //                           child: CircularProgressIndicator(),
    //                         )
    //                       : GestureDetector(
    //                           onTap: () {
    //                             Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     const ShopProductDetail(),
    //                               ),
    //                             );
    //                           },
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               border: Border.all(width: .1),
    //                               borderRadius: BorderRadius.circular(10),
    //                             ),
    //                             child: Row(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Column(
    //                                   children: [
    //                                     item.imageThumbnail == null ||
    //                                             item.imageThumbnail == ""
    //                                         ? Image.asset(
    //                                             "assets/images/no_img.jpg",
    //                                             height: 90,
    //                                           )
    //                                         : Image.network(
    //                                             ProviderUrl.getImageUrlApi +
    //                                                 item.imageThumbnail!,
    //                                             height: 90,
    //                                           ),
    //                                   ],
    //                                 ),
    //                                 Expanded(
    //                                   child: Column(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.center,
    //                                     children: [
    //                                       Row(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         children: [
    //                                           Column(
    //                                             crossAxisAlignment:
    //                                                 CrossAxisAlignment.start,
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                     const EdgeInsets.all(5),
    //                                                 child: Text(
    //                                                     "${item.productCode}"),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                     const EdgeInsets.all(5),
    //                                                 child: Text(
    //                                                     "${item.productName}"),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                     const EdgeInsets.all(5),
    //                                                 child: Container(
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(5),
    //                                                     color: primary,
    //                                                   ),
    //                                                   child: Padding(
    //                                                     padding:
    //                                                         const EdgeInsets
    //                                                             .all(5),
    //                                                     child: Text(
    //                                                       "\$${item.price}",
    //                                                       style:
    //                                                           const TextStyle(
    //                                                         fontSize: 14,
    //                                                         color: Colors.white,
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           Column(
    //                                             mainAxisAlignment:
    //                                                 MainAxisAlignment
    //                                                     .spaceBetween,
    //                                             children: [
    //                                               Text("${item.qtyInStock}"),
    //                                               IconButton(
    //                                                 icon: const Icon(
    //                                                   Icons.add_shopping_cart,
    //                                                   color: primary,
    //                                                 ),
    //                                                 onPressed: () {
    //                                                   setState(() {
    //                                                     addProductCart(
    //                                                       item.id,
    //                                                       item.productCode,
    //                                                       item.productName,
    //                                                       item.price,
    //                                                     );
    //                                                     selectedProductOrde.add(
    //                                                       Product(
    //                                                         id: item.id,
    //                                                         shopId: item.shopId,
    //                                                         productCode: item
    //                                                             .productCode,
    //                                                         productName: item
    //                                                             .productName,
    //                                                         description: item
    //                                                             .description,
    //                                                         qtyInStock:
    //                                                             item.qtyInStock,
    //                                                         price: item.price,
    //                                                         currencyId:
    //                                                             item.currencyId,
    //                                                         cutStockType: item
    //                                                             .cutStockType,
    //                                                         expiredDate: item
    //                                                             .expiredDate,
    //                                                         linkVideo:
    //                                                             item.linkVideo,
    //                                                         imageThumbnail: item
    //                                                             .imageThumbnail,
    //                                                         status: item.status,
    //                                                       ),
    //                                                     );
    //                                                     itemList.add(
    //                                                         item.id.toString());
    //                                                     addToCard++;
    //                                                   });
    //                                                 },
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                 );
    //               },
    //             )
    //           ],
    //         ),
    // );
  }

  Future<void> addProductCart(id, proCode, proName, price) async {
    await ProductCartDB.insertProductCart(id, proCode, proName, price);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.grey,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
