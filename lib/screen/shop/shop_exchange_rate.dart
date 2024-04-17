import 'package:aladang_app/helpdata/exchange_rate_data.dart';
import 'package:aladang_app/screen/shop/shop_exchange_rate_add.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpdata/currency_data.dart';
import '../../model/currency/Currency.dart';
import '../../model/exchangerate/ExchangeRate.dart';

class ShopExchangeRate extends StatefulWidget {
  const ShopExchangeRate({Key? key}) : super(key: key);

  @override
  State<ShopExchangeRate> createState() => _ShopExchangeRateState();
}

class _ShopExchangeRateState extends State<ShopExchangeRate> {
  List<ExchangeRate> exchangeRateList = [];
  ExchangeRate exchangeRate = ExchangeRate();
  ScrollController sc = ScrollController();
  bool _isLoading = false;
  int page = 1;

  int count = 0;

  int? shopid;
  Currency currency = Currency();
  void getCurrencyById(id) async {
    var result = await CurrencyData().getCurrencyById(id);
    setState(() {
      currency = result.data!;
    });
  }

  void getExchangeList(id) async {
    _isLoading = true;
    var result = await ExchangeRateData().getExchangeRateByShopId(id);
    setState(() {
      exchangeRate = result.data!;
      count = result.count!;
      _isLoading = false;
      page++;
    });
  }

  void getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopid = prefs.getInt(SHOP_ID);
      getExchangeList(shopid);
    });
  }

  @override
  void initState() {
    super.initState();

    getLogin();
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        getExchangeList(shopid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "setting".tr() + " " + "exchange".tr(),
        ),
        backgroundColor: primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopExchnageRateCreate(
                    exchangeRate: null,
                  ),
                ),
              ).then(
                (value) {
                  if (value == true) {
                    setState(() {
                      exchangeRateList = [];
                      getExchangeList(shopid);
                    });
                  }
                },
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text('${'rate'.tr()}: ${exchangeRate.rate}'),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
