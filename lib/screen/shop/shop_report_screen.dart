import 'package:aladang_app/component/input_datetime_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class ShopReport extends StatefulWidget {
  const ShopReport({Key? key}) : super(key: key);

  @override
  State<ShopReport> createState() => _ShopReportState();
}

class _ShopReportState extends State<ShopReport> {
  TextEditingController txtFromDate = TextEditingController();
  TextEditingController txtToDate = TextEditingController();

  // void _showdatapicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.8),
            indicatorColor: Colors.green,
            onTap: (selectedIndex) {},
            tabs: [
              Tab(
                // text: "All ${productAll.length}",
                child: Text(
                  "daily".tr(),
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              Tab(
                // text: "Active $countActive",
                child: Text(
                  "monthly".tr(),
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              Tab(
                //text: "Expire $countExpire",
                child: Text(
                  "yearly".tr(),
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              Tab(
                // text: "Out Of Stock $countOutOfStock",
                child: Text(
                  "detail".tr(),
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              Tab(
                //text: "Delete $countDelete",
                child: Text(
                  "summary".tr(),
                  style: TextStyle(fontSize: textSize),
                ),
              ),
            ],
          ),
          title: Text(
            "report".tr(),
            style: TextStyle(fontSize: textSizeTitle),
          ),
          backgroundColor: primary,
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("No Data!")),
            Center(child: Text("No Data!")),
            Center(child: Text("No Data!")),
            Center(child: Text("No Data!")),
            Center(child: Text("No Data!")),
          ],
        ),
      ),
    );
  }

  Center buildReport() => const Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: InputDateTimeWidget(
                      name: "From Date",
                      suffixIcon: const Icon(Icons.date_range),
                      //controller: txtFromDate,
                      vertical: 10,
                      horizontal: 0,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: InputDateTimeWidget(
                      name: "To Date",
                      suffixIcon: const Icon(Icons.date_range),
                      // controller: txtToDate,
                      vertical: 10,
                      horizontal: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
