import 'package:aladang_app/helpdata/currency_data.dart';
import 'package:aladang_app/model/currency/Currency.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../component/button_loading_widget.dart';
import '../../component/button_widget.dart';
import '../../component/input_text.dart';

class ShopCurrencyTypeAdd extends StatefulWidget {
  const ShopCurrencyTypeAdd({Key? key, required this.currencyModel})
      : super(key: key);
  final Currency? currencyModel;
  @override
  State<ShopCurrencyTypeAdd> createState() => _ShopCurrencyTypeAddState();
}

class _ShopCurrencyTypeAddState extends State<ShopCurrencyTypeAdd> {
  static final _keyValidationForm = GlobalKey<FormState>();
  final TextEditingController _txtCurrencyName = TextEditingController();
  final TextEditingController _txtSign = TextEditingController();

  bool _isLoading = false;
  Currency currencys = Currency();
  @override
  void initState() {
    if (widget.currencyModel != null) {
      currencys = widget.currencyModel!;
      _txtCurrencyName.text = currencys.currencyname.toString();
      _txtSign.text = currencys.sign.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.currencyModel == null
              ? "create".tr() + "currency".tr()
              : "update".tr() + "currency".tr(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.currencyModel == null ? create() : update();
            },
            child: Text(
              widget.currencyModel == null ? 'save'.tr() : 'update'.tr(),
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
                          controller: _txtCurrencyName,
                          name: "currency".tr(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          controller: _txtSign,
                          name: "sign".tr(),
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

  create() {
    if (_keyValidationForm.currentState!.validate()) {
      EasyLoading.show(status: "Loading...!");
      Currency req = Currency();
      req.id = 0;
      req.currencyname = _txtCurrencyName.text;
      req.sign = _txtSign.text;
      req.status = "Active";

      CurrencyData().insertCurrency(req).then((value) async {
        await EasyLoading.showSuccess('Insert data successfully!',
            duration: const Duration(seconds: 2));
        Navigator.pop(context, true);
      }).catchError((onError) {
        _isLoading = false;
        showErrorMessage("Invalid data!");
      });
    }
  }

  update() {
    if (_keyValidationForm.currentState!.validate()) {
      EasyLoading.show(status: "Loading...!");
      Currency req = Currency();
      req.id = currencys.id;
      req.currencyname = _txtCurrencyName.text;
      req.sign = _txtSign.text;
      req.status = "Active";

      CurrencyData().updateCurrency(req).then((value) async {
        await EasyLoading.showSuccess('Update data successfully!',
            duration: const Duration(seconds: 2));
        Navigator.pop(context, true);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
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
