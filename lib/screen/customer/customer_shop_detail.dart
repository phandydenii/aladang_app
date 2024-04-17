import 'package:aladang_app/screen/customer/customer_cart.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import '../../component/input_text_search.dart';
import '../../helpdata/product_data.dart';
import '../../helper/product_cart_db.dart';
import '../../model/product/Product.dart';
import '../../model/shop/Shop.dart';
import '../../servies_provider/provider_url.dart';
import '../../utils/constant.dart';

// ignore: must_be_immutable
class CustomerShopDetail extends StatefulWidget {
  CustomerShopDetail({Key? key, this.shop}) : super(key: key);
  Shop? shop;
  @override
  State<CustomerShopDetail> createState() => _CustomerShopDetailState();
}

class _CustomerShopDetailState extends State<CustomerShopDetail> {
  List<Product> selectedProductOrde = [];

  final CarouselController controller = CarouselController();
  TextEditingController isChecekC = TextEditingController();
  bool _isLoading = false;
  List<Product> productAll = [];
  List<Product> productResult = [];
  List<Product> productActive = [];

  int currenPageAll = 1;
  int currenPageActive = 1;

  int currentIndex = 0;
  int page = 1;
  int addToCard = 0;

  void getProductByShopId(shopid, page, status) async {
    _isLoading = true;
    var result = await ProductData().getProductByShopId(shopid, page, status);
    setState(() {
      if (status == "Active") {
        productActive = productActive + result.data!;
        currenPageActive++;
      } else if (status == "all") {
        productAll = productAll + result.data!;
        currenPageActive++;
      }
      _isLoading = false;
    });
  }

  void buildSearch(String txt) {
    setState(() {
      if (txt.isEmpty) {
        productAll = productAll;
      } else {
        productAll = productAll
            .where((element) =>
                element.productName!.toLowerCase().contains(txt.toLowerCase()))
            .toList();
      }
    });
  }

  void countItem() async {
    final data = await ProductCartDB.coutItem();
    setState(() {
      addToCard = data[0]['count'];
    });
  }

  @override
  void initState() {
    countItem();
    getProductByShopId(widget.shop?.id, currenPageActive, "Active");
    getProductByShopId(widget.shop?.id, currenPageActive, "all");
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
                          builder: (context) => CustomerCart(
                            itemList: selectedProductOrde,
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
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child:
                widget.shop!.logoShop!.isEmpty || widget.shop!.logoShop == null
                    ? Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey[400],
                          size: 70,
                        ),
                      )
                    : Image.network(
                        ProviderUrl.getImageUrlApi + widget.shop!.logoShop!,
                        fit: BoxFit.cover,
                      ),
          ),
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
                                                        width: width * 0.2,
                                                        height: height * 0.09,
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
                                                  : Image.network(
                                                      ProviderUrl
                                                              .getImageUrlApi +
                                                          item.imageThumbnail!,
                                                      height: 110,
                                                      width: 110,
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
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons
                                                                .add_shopping_cart,
                                                            color: primary,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
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
                                                                  shopId: item
                                                                      .shopId,
                                                                  productCode: item
                                                                      .productCode,
                                                                  productName: item
                                                                      .productName,
                                                                  description: item
                                                                      .description,
                                                                  qtyInStock: item
                                                                      .qtyInStock,
                                                                  price: item
                                                                      .price,
                                                                  currencyId: item
                                                                      .currencyId,
                                                                  cutStockType:
                                                                      item.cutStockType,
                                                                  expiredDate: item
                                                                      .expiredDate,
                                                                  linkVideo: item
                                                                      .linkVideo,
                                                                  imageThumbnail:
                                                                      item.imageThumbnail,
                                                                  status: item
                                                                      .status,
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

    // : CustomScrollView(
    //     slivers: [
    //       SliverAppBar(
    //         leading: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             decoration: const BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: primary,
    //             ),
    //             child: IconButton(
    //               icon: const Icon(Icons.arrow_back_ios_new),
    //               color: Colors.white,
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //             ),
    //           ),
    //         ),
    //         actions: [
    //           Stack(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Container(
    //                   decoration: const BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     color: primary,
    //                   ),
    //                   child: IconButton(
    //                     icon: const Icon(Icons.add_shopping_cart),
    //                     color: Colors.white,
    //                     onPressed: () {
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                           builder: (context) => CustomerCart(
    //                             itemList: selectedProductOrde,
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 right: 4,
    //                 child: Container(
    //                   decoration: const BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     //borderRadius: BorderRadius.circular(10),
    //                     color: Colors.green,
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(7),
    //                     child: Text(
    //                       "$addToCard",
    //                       style: const TextStyle(color: Colors.white),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //         automaticallyImplyLeading: false,
    //         backgroundColor: Colors.white,
    //         expandedHeight: height / 4.7,
    //         floating: true,
    //         pinned: true,
    //         flexibleSpace: FlexibleSpaceBar(
    //           background: widget.shop!.logoShop!.isEmpty ||
    //                   widget.shop!.logoShop == null
    //               ? Container(
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey,
    //                     borderRadius: BorderRadius.circular(
    //                       10,
    //                     ),
    //                   ),
    //                   child: Center(
    //                     child: Icon(
    //                       Icons.camera_alt_outlined,
    //                       color: Colors.grey[400],
    //                       size: 70,
    //                     ),
    //                   ),
    //                 )
    //               : Image.network(
    //                   ProviderUrl.getImageUrlApi +
    //                       widget.shop!.logoShop!,
    //                 ),
    //         ),
    //       ),
    //       SliverToBoxAdapter(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(15),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "${widget.shop?.shopName}",
    //                     style: const TextStyle(
    //                       color: primary,
    //                       fontSize: textSizeTitle,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   Text(
    //                     "Location: ${widget.shop?.location}",
    //                     style: const TextStyle(
    //                       color: primary,
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                   Text(
    //                     "Tell: ${widget.shop?.phone}",
    //                     style: const TextStyle(
    //                       color: primary,
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(
    //                   horizontal: 10, vertical: 5),
    //               child: InputTextSearch(
    //                 //controller: txtSearch,
    //                 prefixIcon: const Icon(
    //                   Icons.search,
    //                   color: Colors.black,
    //                 ),
    //                 name: "Search shop here!",
    //                 onChange: (value) {
    //                   buildSearch(value);
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SliverList.builder(
    //         itemCount: productAll.length,
    //         itemBuilder: (context, index) {
    //           final item = productAll[index];
    //           return Padding(
    //             padding: const EdgeInsets.symmetric(
    //                 horizontal: 15, vertical: 5),
    //             child: _isLoading == true
    //                 ? const Center(
    //                     child: CircularProgressIndicator(),
    //                   )
    //                 : GestureDetector(
    //                     onTap: () {
    //                       // Navigator.push(
    //                       //   context,
    //                       //   MaterialPageRoute(
    //                       //     builder: (context) => ShopProductDetail(),
    //                       //   ),
    //                       // );
    //                     },
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         border: Border.all(width: .1),
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                       child: Row(
    //                         crossAxisAlignment:
    //                             CrossAxisAlignment.start,
    //                         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Column(
    //                             children: [
    //                               item.imageThumbnail!.isEmpty ||
    //                                       item.imageThumbnail == null
    //                                   ? Padding(
    //                                       padding:
    //                                           const EdgeInsets.all(5),
    //                                       child: Container(
    //                                         decoration: BoxDecoration(
    //                                           color: Colors.grey,
    //                                           borderRadius:
    //                                               BorderRadius.circular(
    //                                             10,
    //                                           ),
    //                                         ),
    //                                         width: width * 0.2,
    //                                         height: height * 0.09,
    //                                         child: Center(
    //                                           child: Icon(
    //                                             Icons
    //                                                 .camera_alt_outlined,
    //                                             color: Colors.grey[400],
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     )
    //                                   : Image.network(
    //                                       ProviderUrl.getImageUrlApi +
    //                                           item.imageThumbnail!,
    //                                       height: 110,
    //                                       width: 110,
    //                                     ),
    //                             ],
    //                           ),
    //                           Expanded(
    //                             child: Column(
    //                               crossAxisAlignment:
    //                                   CrossAxisAlignment.center,
    //                               children: [
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment
    //                                           .spaceBetween,
    //                                   children: [
    //                                     Column(
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.start,
    //                                       children: [
    //                                         Padding(
    //                                           padding:
    //                                               const EdgeInsets.all(
    //                                                   5),
    //                                           child: Text(
    //                                               "${item.productName}"),
    //                                         ),
    //                                         Padding(
    //                                           padding:
    //                                               const EdgeInsets.all(
    //                                                   5),
    //                                           child: Text(
    //                                               "${item.description}"),
    //                                         ),
    //                                         Padding(
    //                                           padding:
    //                                               const EdgeInsets.all(
    //                                                   5),
    //                                           child: Container(
    //                                             decoration:
    //                                                 BoxDecoration(
    //                                               borderRadius:
    //                                                   BorderRadius
    //                                                       .circular(5),
    //                                               color: primary,
    //                                             ),
    //                                             child: Padding(
    //                                               padding:
    //                                                   const EdgeInsets
    //                                                       .all(5),
    //                                               child: Text(
    //                                                 "\$${item.price}",
    //                                                 style:
    //                                                     const TextStyle(
    //                                                   fontSize: 14,
    //                                                   color:
    //                                                       Colors.white,
    //                                                 ),
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment
    //                                               .spaceBetween,
    //                                       children: [
    //                                         IconButton(
    //                                           icon: const Icon(
    //                                             Icons.add_shopping_cart,
    //                                             color: primary,
    //                                           ),
    //                                           onPressed: () {
    //                                             setState(() {
    //                                               addProductCart(
    //                                                 item.id,
    //                                                 item.productCode,
    //                                                 item.productName,
    //                                                 item.price,
    //                                               );
    //                                               selectedProductOrde
    //                                                   .add(
    //                                                 Product(
    //                                                   id: item.id,
    //                                                   shopId:
    //                                                       item.shopId,
    //                                                   productCode: item
    //                                                       .productCode,
    //                                                   productName: item
    //                                                       .productName,
    //                                                   description: item
    //                                                       .description,
    //                                                   qtyInStock: item
    //                                                       .qtyInStock,
    //                                                   price: item.price,
    //                                                   currencyId: item
    //                                                       .currencyId,
    //                                                   cutStockType: item
    //                                                       .cutStockType,
    //                                                   expiredDate: item
    //                                                       .expiredDate,
    //                                                   linkVideo: item
    //                                                       .linkVideo,
    //                                                   imageThumbnail: item
    //                                                       .imageThumbnail,
    //                                                   status:
    //                                                       item.status,
    //                                                 ),
    //                                               );
    //                                               addToCard++;
    //                                             });
    //                                           },
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
  }

  // Insert a new data to the database
  Future<void> addProductCart(id, proCode, proName, price) async {
    await ProductCartDB.insertProductCart(id, proCode, proName, price);
  }
}
