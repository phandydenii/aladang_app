import 'dart:convert';
import 'dart:io';
import 'package:aladang_app/component/input_text.dart';
import 'package:aladang_app/helpdata/delivery_type_data.dart';
import 'package:aladang_app/helpdata/location_data.dart';
import 'package:aladang_app/helpdata/order_data.dart';
import 'package:aladang_app/helpdata/paymentmethod_data.dart';
import 'package:aladang_app/model/customer/Customer.dart';
import 'package:aladang_app/model/exchangerate/ExchangeRate.dart';
import 'package:aladang_app/model/order/Order.dart';
import 'package:aladang_app/model/order_detail/OrderDetail.dart';
import 'package:aladang_app/model/paymentmenthod/PaymentMethod.dart';
import 'package:aladang_app/model/shop/Shop.dart';
import 'package:aladang_app/screen/customer/customer_bottombar.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../helpdata/order_detail_data.dart';
import '../../helper/product_cart_db.dart';
import '../../model/auth/SignInRes.dart';
import '../../model/deliverytype/DeliveryType.dart';
import '../../model/location/Location.dart';
import '../../model/product/Product.dart';
import '../../model/upload/UploadFileRes.dart';
import '../../servies_provider/provider_url.dart';

class CustomerPaid extends StatefulWidget {
  const CustomerPaid({Key? key}) : super(key: key);
  // List<Product> productList = [];
  @override
  State<CustomerPaid> createState() => _CustomerPaidState();
}

class _CustomerPaidState extends State<CustomerPaid> {
  static final key = GlobalKey<FormState>();
  List<DeliveryType> deliveryList = [];
  List<Location> locationList = [];
  List<PaymentMethod> paymentMethondList = [];

  TextEditingController txtDeliveryType = TextEditingController();
  TextEditingController txtLocation = TextEditingController();
  TextEditingController txtPaymentType = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAmountToPaid = TextEditingController();
  TextEditingController txtBankName = TextEditingController();
  int? deliveryId;
  int? locationId;
  int? paymentId;
  File? _selectFile;
  String? fileName;

  Shop shopSp = Shop();
  Customer customerSp = Customer();
  ExchangeRate exchangeSp = ExchangeRate();

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

  void getSharePre() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      shopSp.id = sp.getInt(SHOP_ID);
      shopSp.shopid = sp.getString(SHOP_NO);
      shopSp.shopName = sp.getString(SHOP_NAME);
      shopSp.phone = sp.getString(PHONE);
      shopSp.paymentType = sp.getString(PAYMENT_TYPE);
      shopSp.qrCodeImage = sp.getString(QRCODE_IMAGE);
      shopSp.bankNameid = sp.getInt(BANK_NAME_ID);
      shopSp.accountName = sp.getString(ACCOUNT_NAME);
      shopSp.accountNumber = sp.getString(ACCOUNT_NUMBER);
      shopSp.location = sp.getString(LOCATION);

      // exchangeSp.id = sp.getInt(EXCHANGE_ID);
      // exchangeSp.rate = sp.getDouble(EXCHANGE_RATE);

      customerSp.id = sp.getInt(CUSTOMER_ID);
    });
  }

  double total = 0;
  double? exrate = 0;
  bool? _checkBox = false;

  Future getImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _selectFile = File(image!.path);
      submitFile(_selectFile!);
    });
  }

  Future getImageFromCamara() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectFile = File(image!.path);
      submitFile(_selectFile!);
    });
  }

  List<Map<String, dynamic>> myData = [];
  void _refreshData() async {
    final data = await ProductCartDB.getProductCartCount();
    setState(() {
      myData = data;
      print(myData);
      for (var item in data) {
        total = total + (item['price'] * item['count']);
      }
    });
  }

  @override
  void initState() {
    _refreshData();
    getDeliveryTypeList();
    getPaymentMethodList();
    getLocationList();
    getSharePre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "payment".tr(),
          // style: const TextStyle(color: primary),
        ),
        // backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new,
        //     color: primary,
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "${shopSp.shopName}",
                                    style: const TextStyle(
                                      fontSize: textSizeTitle,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "${shopSp.location}",
                                    style: const TextStyle(
                                      fontSize: textSize,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Invoice No.",
                                                style: const TextStyle(
                                                  fontSize: textSize,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            DateFormat('yyyy-MMM-dd')
                                                .format(DateTime.now())
                                                .toString(),
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
                                  color: Colors.black,
                                ),
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
                                    myData.length,
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
                                            "${myData[index]['productName']}",
                                            style: const TextStyle(
                                              fontSize: textSize,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${myData[index]['count']}",
                                            style: const TextStyle(
                                              fontSize: textSize,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${myData[index]['price']}",
                                            style: const TextStyle(
                                              fontSize: textSize,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Grand Total",
                                      style: TextStyle(
                                        fontSize: textSize,
                                      ),
                                    ),
                                    Text(
                                      "\$$total",
                                      style: TextStyle(
                                        fontSize: textSize,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Text(
                                //       "\៛${total * exchangeSp.rate!}",
                                //       style: TextStyle(
                                //         fontSize: textSize,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                const Center(
                                  child: Text(
                                    "Thanks for ordering!. Please come again!",
                                    style: TextStyle(
                                      fontSize: textSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: InputText(
                          name: "phone".tr(),
                          controller: txtPhone,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: InputText(
                          readOnly: true,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          name: "delivery_type".tr(),
                          controller: txtDeliveryType,
                          onTap: () {
                            _buildDeliveryType();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: InputText(
                          readOnly: true,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          name: "payment_type".tr(),
                          controller: txtPaymentType,
                          onTap: () {
                            _buildPaymentType();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: InputText(
                          name: "location".tr(),
                          controller: txtLocation,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 10,
                      //     vertical: 5,
                      //   ),
                      //   child: TextFormField(
                      //       controller: txtLocation,
                      //       minLines: 3,
                      //       keyboardType: TextInputType.multiline,
                      //       maxLines: null,
                      //       decoration: InputDecoration(
                      //         hintText: "Your location...!",
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //       )),
                      // ),
                      Row(
                        children: [
                          Checkbox(
                            value: _checkBox,
                            checkColor: Colors.white,
                            activeColor: Colors.deepPurple,
                            // tristate: true,
                            onChanged: (val) {
                              setState(() {
                                _checkBox = !_checkBox!;
                                _checkBox = val;
                              });
                            },
                          ),
                          Text(
                            "show_qrcode".tr(),
                            style: TextStyle(
                              fontSize: textSize,
                            ),
                          )
                        ],
                      ),
                      if (_checkBox == true)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            color: Colors.grey[200],
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(
                                    "qr_code_image".tr(),
                                    style: TextStyle(
                                      fontSize: textSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          "assets/images/qr.png",
                                          width: 200,
                                          height: 200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(
                                    "bank_account".tr(),
                                    style: TextStyle(
                                      fontSize: textSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${shopSp.bankNameid}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        Text(
                                          "${shopSp.accountName}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        Text(
                                          "${shopSp.accountNumber}",
                                          style: const TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "upload_transaction".tr(),
                                  style: const TextStyle(
                                    fontSize: textSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.24,
                                    height: MediaQuery.of(context).size.height *
                                        0.24,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4, color: Colors.black26),
                                    ),
                                    child: ClipRRect(
                                      child: _selectFile == null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.grey[400],
                                                  size: 70,
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              // borderRadius: BorderRadius.circular(1000),
                                              child: Image.file(
                                                File(_selectFile!.path),
                                                fit: BoxFit.cover,
                                              ),
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop()
                                      ..pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // <-- Radius
                                    ),
                                  ),
                                  child: Text("cancel".tr()),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showAlertDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ), // <-- Radius
                                    ),
                                  ),
                                  child: Text("order".tr()),
                                ),
                              ),
                            ),
                          ],
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
    if (key.currentState!.validate()) {
      setState(() {});
      EasyLoading.show(status: 'loading...');
      Order req = Order();
      req.id = 0;
      req.invoiceNo = 1;
      req.date = "2023-08-12T13:32:10.15";
      req.shopId = shopSp.id;
      req.customerId = customerSp.id;
      req.deliveryTypeIn = txtDeliveryType.text;
      req.currentLocation = txtLocation.text;
      req.phone = txtPhone.text;
      req.paymentType = txtPaymentType.text;
      req.qrcodeShopName = shopSp.qrCodeImage;
      req.bankName = txtPaymentType.text;
      req.accountName = shopSp.accountName;
      req.accountNumber = shopSp.accountNumber;
      req.receiptUpload = fileName ?? "";
      req.amountTobePaid = total;
      req.exchangeId = exchangeSp.id;
      req.status = "NotPaid";
      OrderData().insertOrder(req).then((value) {
        for (int i = 0; i < myData.length; i++) {
          createOrderDetail(value.data?.id, myData[i]['productId'],
              myData[i]['count'], myData[i]['price']);
        }
        setState(() {});
        EasyLoading.showSuccess('Order Success!',
            duration: const Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerBottomBar(
              index: 1,
            ),
          ),
        );
        truncateProductCart();
        CustomerBottomBar(index: 1);
      }).catchError((onError) {
        EasyLoading.showToast(
          'Faild!',
          duration: const Duration(
            seconds: 5,
          ),
        );
      });
    }
  }

  createOrderDetail(orderid, proid, qty, price) {
    setState(() {});
    OrderDetail req = OrderDetail();
    req.id = 0;
    req.orderid = orderid;
    req.productid = proid;
    req.qty = qty;
    req.price = price;
    req.discount = 0.0;
    OrderDetailData().insertOrderDetail(req).then((value) {
      setState(() {});
    }).catchError((onError) {
      showErrorMessage("Invalid data!");
    });
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

  _buildDeliveryType() {
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
                          itemCount: deliveryList.length,
                          itemBuilder: (context, index) {
                            final item = deliveryList[index];
                            return GestureDetector(
                              onTap: () {
                                deliveryId = item.id;
                                txtDeliveryType.text = item.deliveryName!;
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
                                //print("${item.id}");
                              },
                              child: ListTile(
                                subtitle: Column(
                                  children: [
                                    Text(
                                      "${item.deliveryName}",
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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
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
          ),
        );
      },
    );
  }

  _buildPaymentType() {
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
                          itemCount: paymentMethondList.length,
                          itemBuilder: (context, index) {
                            final item = paymentMethondList[index];
                            return GestureDetector(
                              onTap: () {
                                paymentId = item.id;
                                txtPaymentType.text = item.methodname!;
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
                                //print("${item.id}");
                              },
                              child: ListTile(
                                subtitle: Column(
                                  children: [
                                    Text(
                                      "${item.methodname}",
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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
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
          ),
        );
      },
    );
  }

  _buildLocation() {
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
                          itemCount: locationList.length,
                          itemBuilder: (context, index) {
                            final item = locationList[index];
                            return GestureDetector(
                              onTap: () {
                                locationId = item.id;
                                txtLocation.text = item.location!;
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
                                //print("${item.id}");
                              },
                              child: ListTile(
                                subtitle: Column(
                                  children: [
                                    Text(
                                      "${item.location}",
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
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
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

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Are your sure?'),
        content: const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              create();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
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
              // ignore: avoid_print
              print(model.filename);
            } else {
              // ignore: avoid_print
              print("Faild");
              // ignore: avoid_print
              print(getToken());
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

  Future<void> truncateProductCart() async {
    await ProductCartDB.truncateProductCart();
  }
}
