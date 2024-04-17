import 'dart:convert';

import 'package:aladang_app/helpdata/paymentmethod_data.dart';
import 'package:aladang_app/helpdata/shop_data.dart';
import 'package:aladang_app/model/shop/Shop.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../component/input_datetime_widget.dart';
import '../../component/input_passowrd.dart';
import '../../component/input_text.dart';
import '../../helpdata/location_data.dart';
import '../../model/location/Location.dart';
import '../../model/paymentmenthod/PaymentMethod.dart';
import 'package:http/http.dart' as http;

import '../../model/upload/UploadFileRes.dart';
import '../../servies_provider/provider_url.dart';

class ShopEditProfile extends StatefulWidget {
  const ShopEditProfile({Key? key, required this.titleid, this.shop})
      : super(key: key);
  final int titleid;
  final Shop? shop;
  @override
  State<ShopEditProfile> createState() => _ShopEditProfileState();
}

class _ShopEditProfileState extends State<ShopEditProfile> {
  static final key = GlobalKey<FormState>();
  final TextEditingController txtShopId = TextEditingController();
  final TextEditingController txtShopName = TextEditingController();
  final TextEditingController txtGender = TextEditingController();
  final TextEditingController txtDOB = TextEditingController();
  final TextEditingController txtNationality = TextEditingController();
  final TextEditingController txtShopOwnerName = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtNewPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  final TextEditingController txtTokenId = TextEditingController();
  final TextEditingController txtFacebookPage = TextEditingController();
  final TextEditingController txtLocation = TextEditingController();
  final TextEditingController txtLogoShop = TextEditingController();
  final TextEditingController txtPaymentType = TextEditingController();
  final TextEditingController txtQrCodeImage = TextEditingController();
  final TextEditingController txtBankNameId = TextEditingController();
  final TextEditingController txtAccountNumber = TextEditingController();
  final TextEditingController txtAccountName = TextEditingController();
  final TextEditingController txtFeeType = TextEditingController();
  final TextEditingController txtFeeCharge = TextEditingController();
  final TextEditingController txtShopHistoryDate = TextEditingController();
  final TextEditingController txtNote = TextEditingController();
  final TextEditingController txtIDCard = TextEditingController();
  final TextEditingController txtExpireDate = TextEditingController();

  List<Location> locationList = [];
  void getLocationAllList() async {
    var result = await LocationData().getLocationAllList();
    setState(() {
      locationList = result.data!;
    });
  }

  List<PaymentMethod> paymentMethodList = [];
  void getPaymentMethodList() async {
    var result = await PaymentMethodData().getPaymentMethodAll();
    setState(() {
      paymentMethodList = result.data!;
    });
  }

  Shop sh = Shop();
  @override
  void initState() {
    if (widget.shop != null) {
      sh = widget.shop!;
      txtShopId.text = sh.shopid!;
      txtShopName.text = sh.shopName!;
      txtGender.text = sh.gender!;
      txtDOB.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(sh.dob!));
      txtNationality.text = sh.nationality!;
      txtShopOwnerName.text = sh.ownerName!;
      txtPhone.text = sh.phone!;
      txtFacebookPage.text = sh.facebookPage!;
      // txtPassword.text = sh.password!;
      // txtTokenId.text = sh.tokenid;
      txtLocation.text = sh.location!;
      txtLogoShop.text = sh.logoShop!;
      txtPaymentType.text = sh.paymentType!;
      txtQrCodeImage.text = sh.qrCodeImage!;
      txtBankNameId.text = sh.bankNameid!.toString();
      txtAccountName.text = sh.accountName!;
      txtAccountNumber.text = sh.accountNumber!;
      txtFeeType.text = sh.feetype!;
      txtFeeCharge.text = sh.feecharge!.toString();
      txtShopHistoryDate.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(sh.shophistorydate!));
      txtNote.text = sh.note!;
      txtIDCard.text = sh.idcard!;
      txtExpireDate.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(sh.expiredate!));
    }

    // getLocationAllList();
    // getPaymentMethodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.titleid == 1
              ? "shop_information".tr()
              : widget.titleid == 2
                  ? "pass&security".tr()
                  : "payment".tr(),
          style: const TextStyle(color: primary),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              updateShop(widget.titleid);
            },
            child: Text("update".tr()),
          ),
        ],
      ),
      body: widget.titleid == 1
          ? SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  children: [
                    // "shopid"
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: InputText(
                        requred: true,
                        controller: txtShopId,
                        name: "Shop Id",
                      ),
                    ),
                    // "shopName"
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: InputText(
                        controller: txtShopName,
                        name: "Shop Name",
                      ),
                    ),

                    // "ownerName": "សាន តា",
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: InputText(
                        controller: txtShopOwnerName,
                        name: "Shop Owner Name",
                      ),
                    ),

                    // "gender": "Male",
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: InputText(
                        controller: txtGender,
                        name: "Gender",
                        onTap: () {
                          buildGender(context);
                        },
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),

                    // "dob": "1998-09-16T00:00:00",
                    InputDateTimeWidget(
                      valid: false,
                      name: "Date Of Birth",
                      controller: txtDOB,
                      prefixIcon: const Icon(Icons.date_range),
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      vertical: 10,
                      horizontal: 20,
                    ),

                    // "nationality": "Khmer",
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: InputText(
                        valid: false,
                        controller: txtNationality,
                        name: "Nationality",
                        //icon: Icons.phone,
                        //isDropdown: false,
                      ),
                    ),

                    // "location":
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 20,
                    //     vertical: 10,
                    //   ),
                    //   child: InputText(
                    //     controller: txtLocation,
                    //     name: "Address",
                    //     suffixIcon: const Icon(Icons.arrow_drop_down),
                    //     // onTap: () {
                    //     //   buildLocation(context);
                    //     // },
                    //   ),
                    // ),

                    // "idcard": "00091711",
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: InputText(
                        valid: false,
                        controller: txtIDCard,
                        name: "Card or Passport",
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: InputText(
                        valid: false,
                        controller: txtFacebookPage,
                        name: "Facebook Page",
                      ),
                    ),
                    // "location":
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                          controller: txtLocation,
                          minLines: 3,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Your address...!",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                          controller: txtNote,
                          minLines: 6,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Write something here...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          : widget.titleid == 2
              ? SingleChildScrollView(
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        // "phone": "09876545",
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: InputText(
                            controller: txtPhone,
                            name: "Phone or Email",
                            //prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        // "password": "09803",
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: PassWordInputText(
                            controller: txtPassword,
                            prefixIcon: const Icon(Icons.lock),
                            name: "Old Password",
                          ),
                        ),
                        // "password": "09803",
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: PassWordInputText(
                            controller: txtNewPassword,
                            prefixIcon: const Icon(Icons.lock),
                            name: "New Passowrd",
                          ),
                        ),
                        // "password": "09803",
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: PassWordInputText(
                            controller: txtConfirmPassword,
                            prefixIcon: const Icon(Icons.lock),
                            name: "Confirm Passowrd",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "QR Code",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.height * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 4,
                                      color: Colors.black26,
                                    ),
                                    // shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    // borderRadius: BorderRadius.circular(1000),
                                    child: _qrCode == null
                                        ? Image.network(
                                            ProviderUrl.getImageUrlApi +
                                                sh.qrCodeImage!,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.file(
                                            _qrCode!,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      getQRCodeImageFromGallery();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        color: Colors.green,
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // "paymentType": "Cash in Dollar",
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: InputText(
                            controller: txtPaymentType,
                            name: "Payment Method",
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            onTap: () {
                              buildPaymentMethod(context);
                            },
                          ),
                        ),

                        // "bankNameid": 1,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: InputText(
                            controller: txtBankNameId,
                            name: "Bank Name Id",
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: InputText(
                            controller: txtAccountNumber,
                            name: "Account Number",
                          ),
                        ),
                        //"accountName": "Zanta",
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: InputText(
                            controller: txtAccountName,
                            name: "Account Name",
                          ),
                        ),

                        // "feetype": "",
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: InputText(
                            controller: txtFeeType,
                            name: "Fee Type",
                          ),
                        ),

                        //"feecharge": 4.1,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: InputText(
                            controller: txtFeeCharge,
                            name: "Fee Charge",
                          ),
                        ),

                        //"shophistorydate": "2022-07-26T00:00:00",
                        InputDateTimeWidget(
                          name: "Shop History Date",
                          controller: txtShopHistoryDate,
                          prefixIcon: const Icon(Icons.date_range),
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          vertical: 10,
                          horizontal: 20,
                        ),

                        //"expiredate": "2025-01-01T00:00:00"
                        InputDateTimeWidget(
                          name: "Expire Date",
                          controller: txtExpireDate,
                          prefixIcon: const Icon(Icons.date_range),
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          vertical: 10,
                          horizontal: 20,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  updateShop(titleid) {
    if (key.currentState!.validate()) {
      EasyLoading.show(status: 'loading...');
      Shop req = Shop();
      if (titleid == 1) {
        req.id = sh.id;
        req.shopid = txtShopId.text;
        req.shopName = txtShopName.text;
        req.ownerName = txtShopOwnerName.text;
        req.gender = txtGender.text;
        req.dob = txtDOB.text;
        req.nationality = txtNationality.text;
        req.location = txtLocation.text;
        req.idcard = txtIDCard.text;
        req.facebookPage = txtFacebookPage.text;
        req.note = txtNote.text;

        req.phone = sh.phone;
        req.password = sh.password;
        req.tokenid = sh.tokenid;
        req.logoShop = sh.logoShop;
        req.paymentType = sh.paymentType;
        req.qrCodeImage = sh.qrCodeImage;
        req.bankNameid = sh.bankNameid;
        req.accountName = sh.accountName;
        req.accountNumber = sh.accountNumber;
        req.feetype = sh.feetype;
        req.feecharge = sh.feecharge;
        req.shophistorydate = sh.shophistorydate;
        req.status = sh.status;
        req.expiredate = sh.expiredate;
      } else if (titleid == 2) {
        if (txtNewPassword.text == txtConfirmPassword.text) {
          req.id = sh.id;
          req.phone = txtPhone.text;
          req.password = txtNewPassword.text;

          req.facebookPage = sh.facebookPage;
          req.shopid = sh.shopid;
          req.shopName = sh.shopName;
          req.gender = sh.gender;
          req.dob = sh.dob;
          req.nationality = sh.nationality;
          req.ownerName = sh.ownerName;
          req.tokenid = sh.tokenid;
          req.location = sh.location;
          req.logoShop = sh.logoShop;
          req.paymentType = sh.paymentType;
          req.qrCodeImage = sh.qrCodeImage;
          req.bankNameid = sh.bankNameid;
          req.accountName = sh.accountName;
          req.accountNumber = sh.accountNumber;
          req.feetype = sh.feetype;
          req.feecharge = sh.feecharge;
          req.shophistorydate = sh.shophistorydate;
          req.note = sh.note;
          req.status = sh.status;
          req.idcard = sh.idcard;
          req.expiredate = sh.expiredate;
        } else {
          txtNewPassword.text = "";
          txtConfirmPassword.text = "";
        }
      } else if (titleid == 3) {
        req.id = sh.id;
        req.qrCodeImage = fileName ?? sh.qrCodeImage;
        req.paymentType = txtPaymentType.text;
        req.bankNameid = int.parse(txtBankNameId.text);
        req.accountName = txtAccountName.text;
        req.accountNumber = txtAccountNumber.text;
        req.feetype = txtFeeType.text;
        req.feecharge = double.parse(txtFeeCharge.text);
        req.shophistorydate = txtShopHistoryDate.text;
        req.expiredate = txtExpireDate.text;

        req.phone = sh.phone;
        req.password = sh.password;
        req.shopid = sh.shopid;
        req.shopName = sh.shopName;
        req.gender = sh.gender;
        req.dob = sh.dob;
        req.nationality = sh.nationality;
        req.ownerName = sh.ownerName;
        req.tokenid = sh.tokenid;
        req.location = sh.location;
        req.logoShop = sh.logoShop;
        req.note = txtNote.text;
        req.status = sh.status;
        req.idcard = txtIDCard.text;
        req.facebookPage = txtFacebookPage.text;
      }

      ShopData().updateShop(req).then((value) async {
        await EasyLoading.showSuccess('Login Success!',
            duration: const Duration(seconds: 2));
        Navigator.pop(context, true);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
      });
    }
  }

  File? _qrCode;

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

  Future getQRCodeImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _qrCode = File(image!.path);
      submitFile(_qrCode!);
    });
  }

  Future getImageFromCamara() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _qrCode = File(image!.path);
    });
  }

  // Future getShopLogoImageFromGallery() async {
  //   final image = await ImagePicker()
  //       .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
  //   setState(() {
  //   });
  // }

  // Future getLogoImageFromCamara() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //   setState(() {
  //   });
  // }

  String? fileName;
  void submitFile(File file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ProviderUrl.updloadSingleFileUrl),
    );
    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
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
              print("Upoaded");
            } else {
              // ignore: avoid_print
              print("Faild");
            }
          },
        );
      },
    );
  }

  void buildLocation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            initialChildSize: 0.23,
            minChildSize: 0.2,
            maxChildSize: 0.75,
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
                        child: const Center(
                          child: Text(
                            "Location",
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
                          itemCount: locationList.length,
                          itemBuilder: (context, index) {
                            final item = locationList[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  txtLocation.text = item.location!;
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
                                          "${item.location}",
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

  List genderList = ['Male', 'Female', 'Other'];
  void buildGender(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            initialChildSize: 0.23,
            minChildSize: 0.2,
            maxChildSize: 0.75,
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
                        child: const Center(
                          child: Text(
                            "Gender",
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
                          itemCount: genderList.length,
                          itemBuilder: (context, index) {
                            final item = genderList[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  txtGender.text = item;
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

  void buildPaymentMethod(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            initialChildSize: 0.23,
            minChildSize: 0.2,
            maxChildSize: 0.75,
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
                        child: const Center(
                          child: Text(
                            "Payment Method",
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
                          itemCount: paymentMethodList.length,
                          itemBuilder: (context, index) {
                            final item = paymentMethodList[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  txtPaymentType.text = item.methodname!;
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
                                          "${item.methodname}",
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
