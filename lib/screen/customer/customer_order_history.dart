import 'package:aladang_app/component/input_text_search.dart';
import 'package:aladang_app/screen/customer/customer_order_detail.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpdata/order_data.dart';
import '../../model/order/Order.dart';
import '../../utils/constant.dart';

class CustomerOrderHistory extends StatefulWidget {
  const CustomerOrderHistory({Key? key}) : super(key: key);

  @override
  State<CustomerOrderHistory> createState() => _CustomerOrderHistoryState();
}

class _CustomerOrderHistoryState extends State<CustomerOrderHistory>
    with SingleTickerProviderStateMixin {
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

  int countAll = 0;
  int countPaid = 0;
  int countReturn = 0;
  int countCancel = 0;

  bool isSearchByDate = false;
  bool isSearchByName = false;

  void getOrderListByCustomerId(cusid, page, status) async {
    _isLoading = true;
    var result = await OrderData().getOrderBySCustomerId(cusid, page, status);
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
        countAll = result.count!;
        pageAll++;
      }
      _isLoading = false;
    });
  }

  int? custid;
  void getOrderHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      custid = prefs.getInt(CUSTOMER_ID);
      if (custid != null) {
        getOrderListByCustomerId(custid, pageAll, "all");
        getOrderListByCustomerId(custid, pagePaid, "Paid");
        getOrderListByCustomerId(custid, pageReturn, "Return");
        getOrderListByCustomerId(custid, pageCancel, "Cancel");
      }
    });
  }

  @override
  void initState() {
    getOrderHistory();
    super.initState();

    scAll.addListener(() {
      if (scAll.position.pixels == scAll.position.maxScrollExtent) {
        getOrderListByCustomerId(custid, pageAll, "all");
      }
    });
    scPaid.addListener(() {
      if (scPaid.position.pixels == scPaid.position.maxScrollExtent) {
        getOrderListByCustomerId(custid, pagePaid, "Paid");
      }
    });
    scReturn.addListener(() {
      if (scReturn.position.pixels == scReturn.position.maxScrollExtent) {
        getOrderListByCustomerId(custid, pageReturn, "Return");
      }
    });
    scCancel.addListener(() {
      if (scCancel.position.pixels == scCancel.position.maxScrollExtent) {
        getOrderListByCustomerId(custid, pageCancel, "Cancel");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.8),
            indicatorColor: Colors.white,
            onTap: (selectedIndex) {},
            tabs: [
              Tab(text: "${"all".tr()} $countAll"),
              Tab(text: "${"paid".tr()} $countPaid"),
              Tab(text: "${"return".tr()} $countReturn"),
              Tab(text: "${"cancel".tr()} $countCancel"),
            ],
          ),
          title: isSearchByName == true
              ? InputTextSearch(name: "Search by date")
              : isSearchByName == true
                  ? InputTextSearch(name: "Search by name")
                  : Text("order_history".tr()),
          backgroundColor: primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              if (isSearchByName == true)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InputTextSearch(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    name: "Search shop here!",
                    onChange: (value) {
                      //buildSearch(value);
                      //change = true;
                    },
                  ),
                ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildOrderHistory(orderAll, scAll),
                    _buildOrderHistory(orderDelivered, scPaid),
                    _buildOrderHistory(orderReturn, scReturn),
                    _buildOrderHistory(orderCancel, scCancel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _buildOrderHistory(itemList, sc) {
    return Center(
      child: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : itemList.isEmpty
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
                            builder: (context) => CustomerOrderDetail(
                              orderid: item.id,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 1,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    'NO: ${item.id}',
                                    style: const TextStyle(
                                      fontSize: textSize,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(item.date))}',
                                    style: const TextStyle(
                                      fontSize: textSize,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    'Amount: ${item.amountTobePaid}',
                                    style: const TextStyle(
                                      fontSize: textSize,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    '${item.status}',
                                    style: const TextStyle(
                                      fontSize: textSize,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  controller: sc,
                ),
    );
  }
}
