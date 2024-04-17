import 'package:aladang_app/helpdata/order_data.dart';
import 'package:aladang_app/screen/shop/shop_order_detail.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/order/Order.dart';
import '../../utils/constant.dart';

class ShopOrderHistory extends StatefulWidget {
  const ShopOrderHistory({Key? key}) : super(key: key);

  @override
  State<ShopOrderHistory> createState() => _ShopOrderHistoryState();
}

class _ShopOrderHistoryState extends State<ShopOrderHistory> {
  List<Order> orderAll = [];
  List<Order> orderDelivered = [];
  List<Order> orderReturn = [];
  List<Order> orderCancel = [];
  bool _isLoading = false;
  ScrollController scAll = ScrollController();
  ScrollController scPaid = ScrollController();
  ScrollController scReturn = ScrollController();
  ScrollController scCancel = ScrollController();

  int pageAll = 1;
  int pagePaid = 1;
  int pageReturn = 1;
  int pageCancel = 1;

  int countPaid = 0;
  int countReturn = 0;
  int countCancel = 0;
  bool isAll = false;

  void getOrderListByShopId(shopid, page, status) async {
    _isLoading = true;
    var result = await OrderData().getOrderByShopId(shopid, page, status);
    setState(() {
      if (status == "Paid") {
        orderDelivered = orderDelivered + result.data!;
        countPaid = result.count!;
        pagePaid++;
      } else if (status == "Return") {
        orderReturn = orderReturn + result.data!;
        countReturn = result.count!;
        pageReturn++;
      } else if (status == "Cancel") {
        orderCancel = orderCancel + result.data!;
        countCancel = result.count!;
        pageCancel++;
      } else if (status == "all") {
        orderAll = orderAll + result.data!;
        pageAll++;
      }
      if (result.countPage == page) {
        isAll = true;
      }
      _isLoading = false;
    });
  }

  int? shopid;
  void getLogint() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopid = prefs.getInt(SHOP_ID);
      if (shopid != null) {
        getOrderListByShopId(shopid, pageAll, "all");
        getOrderListByShopId(shopid, pagePaid, "Paid");
        getOrderListByShopId(shopid, pageReturn, "Return");
        getOrderListByShopId(shopid, pageCancel, "Cancel");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLogint();
    scAll.addListener(() {
      if (scAll.position.pixels == scAll.position.maxScrollExtent) {
        getOrderListByShopId(shopid, pageAll, "all");
      }
    });
    scPaid.addListener(() {
      if (scPaid.position.pixels == scPaid.position.maxScrollExtent) {
        getOrderListByShopId(shopid, pagePaid, "Paid");
      }
    });
    scReturn.addListener(() {
      if (scReturn.position.pixels == scReturn.position.maxScrollExtent) {
        getOrderListByShopId(shopid, pageReturn, "Return");
      }
    });
    scCancel.addListener(() {
      if (scCancel.position.pixels == scCancel.position.maxScrollExtent) {
        getOrderListByShopId(shopid, pageCancel, "Cancel");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(
                          5,
                        )),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          child: Text(
                            '${'all'.tr()} ${orderAll.length}',
                            style: const TextStyle(fontSize: textSize),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "${"paid".tr()} $countPaid",
                            style: const TextStyle(fontSize: textSize),
                          ),
                        ),
                        Tab(
                          child: Text(
                            '${'return'.tr()} $countReturn',
                            style: const TextStyle(fontSize: textSize),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "${"cancel".tr()} $countCancel",
                            style: const TextStyle(fontSize: textSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildOrder(orderAll, scAll),
                      _buildOrder(orderDelivered, scPaid),
                      _buildOrder(orderReturn, scReturn),
                      _buildOrder(orderCancel, scCancel),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildOrder(itemList, sc) {
    return Center(
      child: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refresh,
              child: itemList.isEmpty
                  ? const Center(
                      child: Text("No data!"),
                    )
                  : ListView.builder(
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        final item = itemList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopOrderDetail(
                                  orderid: item.id,
                                ),
                              ),
                            ).then(
                              (value) {
                                if (value == true) {
                                  getOrderListByShopId(shopid, 1, "all");
                                }
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: .5, color: primary),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'INV-NO :${item.invoiceNo}',
                                      style: const TextStyle(
                                        fontSize: textSize,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Date :${DateFormat('yyyy-MM-dd').format(DateTime.parse(item.date))}',
                                      style: const TextStyle(
                                        fontSize: textSize,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Amount :${item.amountTobePaid}',
                                      style: const TextStyle(
                                        fontSize: textSize,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Status :${item.status}',
                                      style: const TextStyle(
                                          fontSize: textSize, color: primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      controller: sc,
                    ),
            ),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      getOrderListByShopId(shopid, 1, "all");
    });
  }
}
