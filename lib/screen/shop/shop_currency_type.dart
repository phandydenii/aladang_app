import 'package:aladang_app/helpdata/currency_data.dart';
import 'package:aladang_app/screen/shop/shop_currency_type_add.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../model/currency/Currency.dart';

class ShopCurrencyType extends StatefulWidget {
  const ShopCurrencyType({Key? key}) : super(key: key);

  @override
  State<ShopCurrencyType> createState() => _ShopCurrencyTypeState();
}

class _ShopCurrencyTypeState extends State<ShopCurrencyType> {
  ScrollController sc = ScrollController();
  List<Currency> currencyList = [];
  bool _isLoading = false;
  int page = 1;
  int count = 0;

  void getCurrencyList() async {
    _isLoading = true;
    var result = await CurrencyData().getCurrencyAll();
    setState(() {
      currencyList = currencyList + result.data!;
      _isLoading = false;
      page++;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrencyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "setting".tr() + " " + "currency".tr(),
        ),
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
                  builder: (context) => const ShopCurrencyTypeAdd(
                    currencyModel: null,
                  ),
                ),
              ).then(
                (value) {
                  if (value == true) {
                    setState(() {
                      currencyList = [];
                      getCurrencyList();
                    });
                  }
                },
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: currencyList.length,
              itemBuilder: (context, index) {
                final item = currencyList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopCurrencyTypeAdd(
                          currencyModel: item,
                        ),
                      ),
                    ).then(
                      (value) {
                        if (value == true) {
                          setState(() {
                            currencyList = [];
                            getCurrencyList();
                          });
                        }
                      },
                    );
                  },
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'currency'.tr()}: ${item.currencyname}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${'sign'.tr()}: ${item.sign}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
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
