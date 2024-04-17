import 'package:aladang_app/class/product_order_detail_view.dart';
import 'package:aladang_app/helpdata/order_detail_data.dart';
import 'package:aladang_app/helpdata/product_data.dart';
import 'package:aladang_app/model/order_detail/OrderDetail.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:flutter/material.dart';

import '../../model/product/Product.dart';

class ShopOrderDetail extends StatefulWidget {
 const ShopOrderDetail({super.key, this.orderid});
  final int? orderid;
  @override
  State<ShopOrderDetail> createState() => _ShopOrderDetailState();
}

class _ShopOrderDetailState extends State<ShopOrderDetail> {
  List<OrderDetail> orderDetailList = [];
  Product product = Product();
  ScrollController sc = ScrollController();
  bool _isLoading = false;
  int page = 1;

  int count = 0;

  Product resultProductById = Product();
  List<ProductOrderDetailView> productOrderDetailView = [];
  void getOrderDetail(orderid) async {
    _isLoading = true;
    var result = await OrderDetailData().getOrderDetailByOrderId(orderid);
    setState(() {
      orderDetailList = result.data!;
      count = result.count!;
      _isLoading = false;
      page++;
    });
    if (result.data!.isNotEmpty) {
      for (int i = 0; i < orderDetailList.length; i++) {
        var result =
            await ProductData().getProductByID(orderDetailList[i].productid);
        setState(() {
          resultProductById = result.data!;

          productOrderDetailView.add(
            ProductOrderDetailView(
              id: orderDetailList[i].id,
              orderid: orderDetailList[i].id,
              productid: orderDetailList[i].id,
              productCode: resultProductById.productCode,
              productName: resultProductById.productName,
              qty: orderDetailList[i].qty,
              price: orderDetailList[i].price,
              discount: orderDetailList[i].discount,
            ),
          );
        });
      }
    }
  }

  void getProductById(productid) async {
    var result = await ProductData().getProductByID(productid);
    setState(() {
      resultProductById = result.data!;
    });
  }

  OrderDetail orderDetail = OrderDetail();
  @override
  void initState() {
    if (widget.orderid != null) {
      getOrderDetail(widget.orderid);
      page++;
    }
    super.initState();
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        getOrderDetail(orderDetail.orderid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text(
          "Order Detail",
          style: TextStyle(color: primary),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: primary,
            )),
      ),
      body: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    DataTable(
                                      //horizontalMargin: 100,
                                      //columnSpacing: 50,
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'ID',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Product Name',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Qty',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Price',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],

                                      rows: List<DataRow>.generate(
                                        productOrderDetailView.length,
                                        (index) => DataRow(
                                          cells: [
                                            DataCell(Text("${index + 1}")),
                                            DataCell(Text(
                                                "${productOrderDetailView[index].productName}")),
                                            DataCell(Text(
                                                "${productOrderDetailView[index].qty}")),
                                            DataCell(Text(
                                                "${productOrderDetailView[index].price}")),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
