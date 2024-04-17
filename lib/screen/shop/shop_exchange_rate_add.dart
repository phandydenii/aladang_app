import 'package:aladang_app/helpdata/exchange_rate_data.dart';
import 'package:aladang_app/model/exchangerate/ExchangeRate.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../component/button_loading_widget.dart';
import '../../component/button_widget.dart';
import '../../component/input_text.dart';
import '../../helpdata/currency_data.dart';
import '../../model/currency/Currency.dart';

class ShopExchnageRateCreate extends StatefulWidget {
  const ShopExchnageRateCreate({Key? key, this.exchangeRate}) : super(key: key);
  final ExchangeRate? exchangeRate;
  @override
  State<ShopExchnageRateCreate> createState() => _ShopExchnageRateCreateState();
}

class _ShopExchnageRateCreateState extends State<ShopExchnageRateCreate> {
  static final _keyValidationForm = GlobalKey<FormState>();
  final TextEditingController _txtCurrency = TextEditingController();
  final TextEditingController _txtExchangeRate = TextEditingController();
  final TextEditingController txtSearch = TextEditingController();
  final TextEditingController test = TextEditingController();

  ExchangeRate exchange = ExchangeRate();
  int? currid;
  int? shopid;
  int page = 1;
  bool _isLoading = false;

  String? selectedCurrency;
  List<Currency> currencyList = [];
  Currency currency = Currency();
  List<Currency> currencyResult = [];

  void getCurrencyList() async {
    _isLoading = true;
    var result = await CurrencyData().getCurrencyAll();
    setState(() {
      currencyList = result.data!;
      currencyResult = result.data!;
      _isLoading = false;
    });
  }

  void getCurrencyById(id) async {
    var result = await CurrencyData().getCurrencyById(id);
    setState(() {
      currency = result.data!;
      _txtCurrency.text = currency.currencyname!;
    });
  }

  @override
  void initState() {
    if (widget.exchangeRate != null) {
      getCurrencyById(widget.exchangeRate!.currencyid);
      exchange = widget.exchangeRate!;
      _txtExchangeRate.text = exchange.rate.toString();
    }
    super.initState();
    getCurrencyList();
  }

  void buildSearch(String txt) {
    setState(() {
      if (txt.isEmpty) {
        currencyList = currencyResult;
      } else {
        currencyList = currencyResult
            .where((element) =>
                element.currencyname!.toLowerCase().contains(txt.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "create".tr() + "exchange".tr(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.exchangeRate == null ? create() : update();
            },
            child: Text(
              widget.exchangeRate == null ? 'save'.tr() : 'update'.tr(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              child: Form(
                key: _keyValidationForm,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          readOnly: true,
                          controller: _txtCurrency,
                          name: "currency".tr(),
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          onTap: () {
                            _buildCurrency();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          controller: _txtExchangeRate,
                          name: "exchange_rate".tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildCurrency() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: primary,
                    ),
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          "Currency",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                          //print("${item.id}");
                        },
                        child: ListView.builder(
                          itemCount: currencyList.length,
                          itemBuilder: (context, index) {
                            final item = currencyList[index];
                            return GestureDetector(
                              onTap: () {
                                _txtCurrency.text = item.currencyname!;
                                currency.id = item.id;
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
                                //print("${item.id}");
                              },
                              child: ListTile(
                                subtitle: Column(
                                  children: [
                                    Text(
                                      "${item.currencyname}",
                                      style:
                                          const TextStyle(fontSize: textSize),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Colors.red,
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Center(
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  create() {
    if (_keyValidationForm.currentState!.validate()) {
      EasyLoading.show(status: "Loading...!");
      ExchangeRate req = ExchangeRate();
      req.id = 0;
      req.date = "2023-08-01T11:24:05.997014+07:00";
      req.currencyid = currency.id;
      req.shopid = shopid;
      req.rate = double.parse(_txtExchangeRate.text);
      ExchangeRateData().insertExchangeRate(req).then((value) async {
        await EasyLoading.showSuccess('Insert data successfully!',
            duration: const Duration(seconds: 2));
        Navigator.pop(context, true);
        Navigator.pop(context, true);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
        _isLoading = false;
      });
    }
  }

  update() {
    if (_keyValidationForm.currentState!.validate()) {
      EasyLoading.show(status: "Loading...!");
      ExchangeRate req = ExchangeRate();
      req.id = exchange.id;
      req.date = "2023-08-01T11:24:05.997014+07:00";
      req.currencyid = 1;
      req.shopid = currency.id;
      req.rate = double.parse(_txtExchangeRate.text);
      ExchangeRateData().updateExchangeRate(req).then((value) async {
        await EasyLoading.showSuccess('Update data successfully!',
            duration: const Duration(seconds: 2));
        Navigator.pop(context, true);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
        _isLoading = false;
      });
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: primary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
