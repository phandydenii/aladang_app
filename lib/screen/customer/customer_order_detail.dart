import 'package:aladang_app/helpdata/order_data.dart';
import 'package:aladang_app/model/location/Location.dart';
import 'package:aladang_app/model/order_detail/OrderDetailViewModelRes.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../helpdata/delivery_type_data.dart';
import '../../helpdata/location_data.dart';
import '../../helpdata/order_detail_data.dart';
import '../../helpdata/paymentmethod_data.dart';
import '../../model/deliverytype/DeliveryType.dart';
import '../../model/order/Order.dart';
import '../../model/paymentmenthod/PaymentMethod.dart';

// ignore: must_be_immutable
class CustomerOrderDetail extends StatefulWidget {
  CustomerOrderDetail({Key? key, required this.orderid}) : super(key: key);
  int? orderid;
  @override
  State<CustomerOrderDetail> createState() => _CustomerOrderDetailState();
}

class _CustomerOrderDetailState extends State<CustomerOrderDetail> {
  TextEditingController txtDeliveryType = TextEditingController();
  TextEditingController txtLocation = TextEditingController();
  TextEditingController txtPaymentType = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAmountToPaid = TextEditingController();
  TextEditingController txtBankName = TextEditingController();

  List<DeliveryType> deliveryList = [];
  List<Location> locationList = [];
  List<PaymentMethod> paymentMethondList = [];
  int? deliveryId;
  int? locationId;
  int? paymentId;

  Order order = Order();
  List<OrderDetailView> orderDetailViewList = [];
  double total = 0;

  void getOrderDetailView(orderid) async {
    var result = await OrderDetailData().getOrderDetailDetailView(orderid);
    setState(() {
      orderDetailViewList = result.data!;
      for (int i = 0; i < orderDetailViewList.length; i++) {
        total = total +
            (orderDetailViewList[i].price! * orderDetailViewList[i].qty!);
      }
      EasyLoading.dismiss();
    });
  }

  void getOrderById(orderid) async {
    var result = await OrderData().getOrderById(orderid);
    setState(() {
      order = result.data!;
      EasyLoading.dismiss();
    });
  }

  void getDeliveryTypeList() async {
    var result = await DeliveryTypeData().getDeliveryList();
    setState(() {
      deliveryList = result.data!;
    });
  }

  void getPaymentMethodList() async {
    var result = await PaymentMethodData().getPaymentMethodAll();
    setState(() {
      paymentMethondList = result.data!;
    });
  }

  void getLocationList() async {
    var result = await LocationData().getLocationAllList();
    setState(() {
      locationList = result.data!;
    });
  }

  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    getDeliveryTypeList();
    getPaymentMethodList();
    getLocationList();
    if (widget.orderid != null) {
      getOrderById(widget.orderid);
      getOrderDetailView(widget.orderid);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("order_detail".tr()),
        // actions: [
        //   TextButton(
        //     onPressed: () {},
        //     child: const Text(
        //       "Edit",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Invoice No: ${order.invoiceNo}",
                                      style: const TextStyle(
                                        fontSize: textSize,
                                      ),
                                    ),
                                    Text(
                                      "Date : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(order.date!))}",
                                      style: const TextStyle(
                                        fontSize: textSize,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery: ${order.deliveryTypeIn}",
                                      style: const TextStyle(
                                        fontSize: textSize,
                                      ),
                                    ),
                                    Text(
                                      "Location : ${order.currentLocation}",
                                      style: const TextStyle(
                                        fontSize: textSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
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
                                          fontSize: textSize,
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
                                          fontSize: textSize,
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
                                          fontSize: textSize,
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
                                          fontSize: textSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],

                                rows: List<DataRow>.generate(
                                  orderDetailViewList.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${orderDetailViewList[index].productName}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${orderDetailViewList[index].qty}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${orderDetailViewList[index].price}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.green,
                                  width: double.infinity,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        "${order.status}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: primary,
                                  width: double.infinity,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        "Total: $total",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
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
