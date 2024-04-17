import 'dart:convert';
import 'dart:io';
import 'package:aladang_app/component/button_widget.dart';
import 'package:aladang_app/helpdata/currency_data.dart';
import 'package:aladang_app/helpdata/product_data.dart';
import 'package:aladang_app/model/currency/Currency.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/input_datetime_widget.dart';
import '../../component/input_text.dart';
import '../../model/auth/SignInRes.dart';
import '../../model/product/Product.dart';
import '../../model/shop/Shop.dart';
import 'package:http/http.dart' as http;

import '../../model/upload/UploadFileRes.dart';

class ShopProductAddScreen extends StatefulWidget {
  const ShopProductAddScreen({Key? key, required this.proid}) : super(key: key);
  final int? proid;
  @override
  State<ShopProductAddScreen> createState() => _ShopProductAddScreenState();
}

class _ShopProductAddScreenState extends State<ShopProductAddScreen> {
  final _formKey = GlobalKey<FormState>();

  File? _selectfile;
  bool _isLoading = false;
  final TextEditingController txtProductCode = TextEditingController();
  final TextEditingController txtProductName = TextEditingController();
  final TextEditingController txtShop = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtQtyInStock = TextEditingController(text: '0');
  final TextEditingController txtExpireDate = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final TextEditingController txtCutStockType = TextEditingController();
  final TextEditingController txtPrice = TextEditingController(text: '0');
  final TextEditingController txtCurrency =
      TextEditingController(text: 'Dollar');
  final TextEditingController txtLinkVideo = TextEditingController();

  Shop shop = Shop();
  List<Currency> currencyList = [];
  Product product = Product();
  Currency currency = Currency();

  void getShopSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shop.id = prefs.getInt(SHOP_ID);
      shop.shopName = prefs.getString(SHOP_NAME);
    });
  }

  void getCurrencyList() async {
    _isLoading = true;
    var result = await CurrencyData().getCurrencyAll();
    setState(() {
      currencyList = result.data!;
      _isLoading = false;
    });
  }

  void getCurrencyById(id) async {
    _isLoading = true;
    var result = await CurrencyData().getCurrencyById(id);
    setState(() {
      currency = result.data!;
      txtCurrency.text = currency.currencyname!;
      _isLoading = false;
    });
  }

  void getProduct(id) async {
    _isLoading = true;
    var result = await ProductData().getProductByID(id);
    setState(() {
      product = result.data!;
      txtProductCode.text = product.productCode!.toString();
      txtProductName.text = product.productName!.toString();
      txtShop.text = product.shopId!.toString();
      txtDescription.text = product.description!.toString();
      txtQtyInStock.text = product.qtyInStock!.toString();
      txtExpireDate.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(product.expiredDate!));
      txtCutStockType.text = product.cutStockType!.toString();
      txtPrice.text = product.price!.toString();
      txtLinkVideo.text = product.linkVideo!;
      getCurrencyById(product.currencyId);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    if (widget.proid != null) {
      getProduct(widget.proid);
    }
    getShopSharePreference();
    getCurrencyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: widget.proid == null
            ? Text(
                "create".tr(),
                style: TextStyle(color: primary),
              )
            : Text(
                "update".tr(),
                style: TextStyle(color: primary),
              ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primary,
          ),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       widget.proid == null ? "save".tr() : "update".tr(),
        //     ),
        //   ),
        // ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            product.imageThumbnail == null ||
                                    product.imageThumbnail == ""
                                ? _selectfile == null
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 3,
                                            color: primary,
                                          ),
                                          // color: Colors.grey,
                                          // borderRadius: BorderRadius.circular(
                                          //   10,
                                          // ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.grey[400],
                                            size: 70,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 4,
                                            color: primary,
                                          ),
                                        ),
                                        child: _isLoading == true
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : ClipRRect(
                                                child: Image.file(
                                                  _selectfile!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      )
                                : Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 4,
                                        color: primary,
                                      ),
                                      // shape: BoxShape.circle,
                                    ),
                                    child: _isLoading == true
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : ClipRRect(
                                            // borderRadius:
                                            //     BorderRadius.circular(10),
                                            child: _selectfile == null
                                                ? Image.network(
                                                    ProviderUrl.getImageUrlApi +
                                                        product.imageThumbnail!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.file(
                                                    _selectfile!,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: getImageFromGallery,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          controller: txtProductCode,
                          name: "product_code".tr(),
                          //onTap: () {},
                          //icon: const Icon(Icons.edit),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          controller: txtProductName,
                          name: "product_name".tr(),
                          //icon: const Icon(Icons.edit),
                        ),
                      ),
                      InputDateTimeWidget(
                        name: 'expire_date'.tr(),
                        controller: txtExpireDate,
                        prefixIcon: const Icon(Icons.date_range),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        vertical: 10,
                        horizontal: 20,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 20,
                      //     vertical: 10,
                      //   ),
                      //   child: InputText(
                      //     controller: txtCutStockType,
                      //     name: "cut_stock_type".tr(),
                      //     //icon: const Icon(Icons.edit),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          readOnly: true,
                          controller: txtCutStockType,
                          name: "cut_stock_type".tr(),
                          onTap: () {
                            _buildCutStockType(context);
                          },
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: InputText(
                                // initialValue: "0",
                                controller: txtQtyInStock,
                                name: "qty_in_stock".tr(),
                                //icon: const Icon(Icons.edit),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: InputText(
                                controller: txtPrice,
                                name: "price".tr(),
                                //icon: const Icon(Icons.edit),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InputText(
                          controller: txtCurrency,
                          name: "currency".tr(),
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          onTap: () {
                            _buildCurrency();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("note".tr()),
                            TextFormField(
                              controller: txtDescription,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "note".tr(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ling_video".tr()),
                            TextFormField(
                              controller: txtLinkVideo,
                              minLines: 4,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "ling_video".tr(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: ButtonWidget(
                                    name: "cancel".tr(),
                                    color: Colors.red,
                                    onClick: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ButtonWidget(
                                    name: widget.proid == null
                                        ? "save".tr()
                                        : "update".tr(),
                                    color: primary,
                                    onClick: () {
                                      widget.proid == null
                                          ? create()
                                          : update();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? fileName;
  Future getImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _selectfile = File(image!.path);
      submitFile(_selectfile!);
    });
  }

  Future getImageFromCamara() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectfile = File(image!.path);
      submitFile(_selectfile!);
    });
  }

  create() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'loading...');

      Product req = Product();
      req.id = 0;
      req.shopId = shop.id;
      req.productCode = txtProductCode.text;
      req.productName = txtProductName.text;
      req.description = txtDescription.text;
      req.qtyInStock = int.parse(txtQtyInStock.text);
      req.currencyId = currency.id;
      req.price = double.parse(txtPrice.text);
      req.cutStockType = txtCutStockType.text;
      req.expiredDate = txtExpireDate.text;
      req.linkVideo = txtLinkVideo.text;
      req.imageThumbnail = fileName ?? "";
      req.status = "Active";
      ProductData().insertProduct(req).then((value) async {
        await EasyLoading.showSuccess('Product has been create!',
            duration: const Duration(seconds: 2));
        Navigator.pop(context, true);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
      });
    }
  }

  update() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'loading...');
      setState(() {
        _isLoading = true;
      });
      Product req = Product();
      req.id = product.id;
      req.shopId = shop.id;
      req.productCode = txtProductCode.text;
      req.productName = txtProductName.text;
      req.description = txtDescription.text;
      req.qtyInStock = int.parse(txtQtyInStock.text);
      req.currencyId = currency.id;
      req.price = double.parse(txtPrice.text);
      req.cutStockType = txtCutStockType.text;
      req.expiredDate = txtExpireDate.text;
      req.linkVideo = txtLinkVideo.text;
      req.imageThumbnail = fileName ?? product.imageThumbnail;
      req.status = "Active";
      ProductData().updateProduct(req).then((value) async {
        await EasyLoading.showSuccess('Product has been update!',
            duration: const Duration(seconds: 2));
        Navigator.pop(context, true);
      }).catchError((onError) {
        _isLoading = false;
        showErrorMessage("Invalid data!");
      });
    }
  }

  void submitFile(File file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        ProviderUrl.basicUrlWebApi + ProviderUrl.updloadSingleFileUrl,
      ),
    );
    var headers1 = {
      'Authorization': 'Bearer ${getToken()}',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    Map<String, String> headers = headers1;
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
      ),
    );
    request.headers.addAll(headers);
    await request.send().then(
      (result) {
        http.Response.fromStream(result).then(
          (response) {
            if (response.statusCode == 200) {
              final map = json.decode(response.body);
              final model = UploadFileRes.fromJson(map);
              fileName = model.filename;
              print(fileName);
            } else {
              // ignore: avoid_print
              print("Faild");
            }
          },
        );
      },
    );
  }

  String getToken() {
    final localStorage = LocalStorage("TOKEN_APP");
    var accessToken = localStorage.getItem("ACCESS_TOKEN");
    SignInRes loginRes = SignInRes.fromJson(accessToken);
    return loginRes.data!.token!;
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
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
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListView.builder(
                          itemCount: currencyList.length,
                          itemBuilder: (context, index) {
                            final item = currencyList[index];
                            return GestureDetector(
                              onTap: () {
                                currency.id = item.id;
                                txtCurrency.text = item.currencyname!;
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
                              },
                              child: ListTile(
                                subtitle: Column(
                                  children: [
                                    Text(
                                      "${item.currencyname}",
                                      style: const TextStyle(fontSize: 16),
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List typelist = ['Immediately cut stock', 'Cut stock after approved'];
  void _buildCutStockType(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.5,
            builder: (_, controller) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      //====== header =====
                      Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "cut_stock_type".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: controller,
                          itemCount: typelist.length,
                          itemBuilder: (context, index) {
                            final item = typelist[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  txtCutStockType.text = item;
                                  FocusScope.of(context).unfocus();
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      // color: Colors.brown,
                                      child: Center(
                                        child: Text(
                                          "$item",
                                          style: const TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      height: 0,
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
