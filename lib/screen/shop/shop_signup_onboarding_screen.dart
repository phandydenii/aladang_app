import 'dart:convert';
import 'dart:io';
import 'package:aladang_app/component/button_widget.dart';
import 'package:aladang_app/screen/shop/shop_home_screen.dart';
import 'package:aladang_app/screen/shop/shop_signin_screen.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/input_datetime_widget.dart';
import '../../component/input_passowrd.dart';
import '../../component/input_text.dart';
import '../../helpdata/auth_data.dart';
import '../../helpdata/exchange_rate_data.dart';
import '../../helpdata/location_data.dart';
import '../../helpdata/paymentmethod_data.dart';
import '../../helpdata/shop_data.dart';
import '../../model/auth/SignInReq.dart';
import '../../model/auth/SignInRes.dart';
import '../../model/exchangerate/ExchangeRate.dart';
import '../../model/location/Location.dart';
import '../../model/paymentmenthod/PaymentMethod.dart';
import '../../model/shop/Shop.dart';
import '../../model/upload/UploadFileRes.dart';
import '../../servies_provider/provider_url.dart';
import 'package:http/http.dart' as http;

class ShopSignUpOnboardingScreen extends StatefulWidget {
  const ShopSignUpOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<ShopSignUpOnboardingScreen> createState() =>
      _ShopSignUpOnboardingScreenState();
}

class _ShopSignUpOnboardingScreenState
    extends State<ShopSignUpOnboardingScreen> {
  static final key1 = GlobalKey<FormState>();
  static final key2 = GlobalKey<FormState>();
  static final key3 = GlobalKey<FormState>();
  final _controller = PageController();

  final TextEditingController txtShopId = TextEditingController();
  final TextEditingController txtShopName = TextEditingController();
  final TextEditingController txtGender = TextEditingController();
  final TextEditingController txtDOB = TextEditingController();
  final TextEditingController txtNationality = TextEditingController();
  final TextEditingController txtShopOwnerName = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
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
  final TextEditingController txtExchangeRate = TextEditingController();

  List<PaymentMethod> paymentMethondList = [];
  bool onLastPage = false;
  File? _selectQRCode;
  File? _selectLogoShop;

  List<Location> locationList = [];
  void getLocationAllList() async {
    var result = await LocationData().getLocationAllList();
    setState(() {
      locationList = result.data!;
    });
  }

  void getPaymentMethodList() async {
    var result = await PaymentMethodData().getPaymentMethodAll();
    setState(() {
      paymentMethondList = result.data!;
    });
  }

  @override
  void initState() {
    //getLocationAllList();
    getPaymentMethodList();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  int? indx = 0;
  bool pageIsScrolling = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("sign_up".tr()),
        leading: IconButton(
          onPressed: () {
            if (_controller.page == 0) {
              Navigator.pop(context);
            }
            _controller.previousPage(
              duration: const Duration(
                milliseconds: 700,
              ),
              curve: Curves.easeInOut,
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          onLastPage
              ? TextButton(
                  onPressed: () {
                    if (indx == 1) {
                      if (key2.currentState!.validate()) {
                        create();
                      }
                    }
                  },
                  child: Text(
                    "sign_up".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    if (indx == 0) {
                      if (key1.currentState!.validate()) {
                        onNextPage();
                      }
                    }
                    // else if (indx == 1) {
                    //   if (key2.currentState!.validate()) {
                    //     onNextPage();
                    //   }
                    // } else {
                    //   if (key3.currentState!.validate()) {
                    //     onNextPage();
                    //   }
                    // }
                  },
                  child: Text(
                    "next".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              //flex: 8,
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    indx = index;
                    onLastPage = (index == 1);
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: key1,
                      child: Column(
                        children: [
                          //Lottie.asset("assets/jsons/business-3.json"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'shop_information'.tr(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: textSizeTitle,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'please_fill_information_to_sign_up'.tr(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: textSizeTitle,
                              ),
                            ),
                          ),

                          // "shopid"
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 20,
                          //     vertical: 10,
                          //   ),
                          //   child: InputText(
                          //     requred: true,
                          //     controller: txtShopId,
                          //     name: "Shop Id",
                          //   ),
                          // ),
                          // "shopName"
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtShopName,
                              name: "shop_name".tr(),
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
                              name: "shop_owner_name".tr(),
                            ),
                          ),

                          // "gender": "Male",
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              readOnly: true,
                              controller: txtGender,
                              name: "gender".tr(),
                              onTap: () {
                                buildGender(context);
                              },
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                          ),

                          // "dob": "1998-09-16T00:00:00",
                          InputDateTimeWidget(
                            valid: false,
                            name: "dob".tr(),
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
                              name: "nationality".tr(),
                              //icon: Icons.phone,
                              //isDropdown: false,
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
                                  hintText: "${"address".tr()}...!",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              textInputType: TextInputType.number,
                              valid: false,
                              controller: txtIDCard,
                              name:
                                  "${"card_no".tr()} ${"or".tr()} ${"passport_no".tr()}",
                              //icon: Icons.phone,
                              //isDropdown: false,
                            ),
                          ),

                          // "expiredate": "2025-01-01T00:00:00"
                          InputDateTimeWidget(
                            name: "expire_date".tr(),
                            controller: txtExpireDate,
                            prefixIcon: const Icon(Icons.date_range),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            vertical: 10,
                            horizontal: 20,
                          ),

                          // "phone": "09876545",
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtPhone,
                              name: "phone_or_email".tr(),
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
                              name: "password".tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /////Screeen 2
                  SingleChildScrollView(
                    child: Form(
                      key: key2,
                      child: Column(
                        children: [
                          //Lottie.asset("assets/jsons/business-3.json"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'shop_information'.tr(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: textSizeTitle,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'please_fill_information_to_sign_up'.tr(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),

                          // "facebookPage": "Zanta.168",
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtFacebookPage,
                              name: "facebook_page".tr(),
                              //suffixIcon: Icon(Icons.arrow_drop_down),
                              //isDropdown: false,
                              onTap: () {
                                //buildPaymentMethod(context);
                              },
                            ),
                          ),

                          // "feetype": "",
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 20,
                          //     vertical: 10,
                          //   ),
                          //   child: InputText(
                          //     controller: txtFeeType,
                          //     name: "fee_type".tr(),
                          //   ),
                          // ),
                          //
                          // // "feecharge": 4.1,
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 20,
                          //     vertical: 10,
                          //   ),
                          //   child: InputText(
                          //     controller: txtFeeCharge,
                          //     name: "fee_charge".tr(),
                          //   ),
                          // ),
                          //
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 20,
                          //     vertical: 10,
                          //   ),
                          //   child: InputText(
                          //     valid: false,
                          //     controller: txtExchangeRate,
                          //     name: "exchange_rate".tr(),
                          //   ),
                          // ),

                          // "shophistorydate": "2022-07-26T00:00:00",
                          InputDateTimeWidget(
                            valid: false,
                            name: "shop_history_date".tr(),
                            controller: txtShopHistoryDate,
                            prefixIcon: const Icon(Icons.date_range),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            vertical: 10,
                            horizontal: 20,
                          ),

                          // // "note": "None",
                          // InputText(
                          //   controller: txtNote,
                          //   name: "Note",
                          // ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "logo_shop".tr(),
                              style: const TextStyle(fontSize: textSizeTitle),
                            ),
                          ),

                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.height * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 4,
                                      color: Colors.black26,
                                    ),
                                    // shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    // borderRadius: BorderRadius.circular(1000),
                                    child: _selectLogoShop == null
                                        ? Container(
                                            width: 80,
                                            height: 80,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.grey[400],
                                                size: 30,
                                              ),
                                            ),
                                          )
                                        : Image.file(
                                            _selectLogoShop!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      getImageFromGalleryLogoShop();
                                    },
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

                          // "paymentType": "Cash in Dollar",
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              readOnly: true,
                              controller: txtPaymentType,
                              name: "payment_method".tr(),
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              //isDropdown: false,
                              onTap: () {
                                buildPaymentMethodList(context);
                              },
                            ),
                          ),
                          if (txtPaymentType.text == "QR Code")
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "qr_code_image".tr(),
                                    style: const TextStyle(
                                      fontSize: textSizeTitle,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 4,
                                            color: Colors.black26,
                                          ),
                                          // shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          // borderRadius: BorderRadius.circular(1000),
                                          child: _selectQRCode == null
                                              ? Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.grey,
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.grey[400],
                                                      size: 30,
                                                    ),
                                                  ),
                                                )
                                              : Image.file(
                                                  _selectQRCode!,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            getImageFromGalleryQRCode();
                                          },
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          if (txtPaymentType.text == "Bank Account")
                            // "bankNameid": 1,
                            Column(
                              children: [
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
                                    name: "account_number".tr(),
                                  ),
                                ),
                                // "accountName": "Zanta",
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: InputText(
                                    controller: txtAccountName,
                                    name: "account_name".tr(),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),

                  //Screeen 3
                  // SingleChildScrollView(
                  //   child: Form(
                  //     key: key3,
                  //     child: Column(
                  //       children: [
                  //         //Lottie.asset("assets/jsons/business-3.json"),
                  //         Padding(
                  //           padding: EdgeInsets.all(8.0),
                  //           child: Text(
                  //             'shop_information'.tr(),
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: textSizeTitle),
                  //           ),
                  //         ),
                  //         Container(
                  //           alignment: Alignment.center,
                  //           child: Text(
                  //             'please_fill_information_to_sign_up'.tr(),
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 14),
                  //           ),
                  //         ),
                  //
                  //         Padding(
                  //           padding: EdgeInsets.all(8.0),
                  //           child: Text(
                  //             "logo_shop".tr(),
                  //             style: TextStyle(fontSize: textSizeTitle),
                  //           ),
                  //         ),
                  //         Center(
                  //           child: Stack(
                  //             children: [
                  //               Container(
                  //                 width:
                  //                     MediaQuery.of(context).size.height * 0.25,
                  //                 height:
                  //                     MediaQuery.of(context).size.height * 0.3,
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(
                  //                     width: 4,
                  //                     color: Colors.black26,
                  //                   ),
                  //                   // shape: BoxShape.circle,
                  //                 ),
                  //                 child: ClipRRect(
                  //                   // borderRadius: BorderRadius.circular(1000),
                  //                   child: _selectLogoShop == null
                  //                       ? Container(
                  //                           width: 80,
                  //                           height: 80,
                  //                           decoration: BoxDecoration(
                  //                             color: Colors.grey,
                  //                           ),
                  //                           child: Center(
                  //                             child: Icon(
                  //                               Icons.camera_alt_outlined,
                  //                               color: Colors.grey[400],
                  //                               size: 30,
                  //                             ),
                  //                           ),
                  //                         )
                  //                       : Image.file(
                  //                           _selectLogoShop!,
                  //                           fit: BoxFit.cover,
                  //                         ),
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 bottom: 0,
                  //                 right: 0,
                  //                 child: InkWell(
                  //                   onTap: () {
                  //                     getImageFromGalleryLogoShop();
                  //                   },
                  //                   child: Container(
                  //                     width: 40,
                  //                     height: 40,
                  //                     decoration: BoxDecoration(
                  //                       shape: BoxShape.circle,
                  //                       border: Border.all(
                  //                           width: 4,
                  //                           color: Theme.of(context)
                  //                               .scaffoldBackgroundColor),
                  //                       color: Colors.green,
                  //                     ),
                  //                     child: const Icon(
                  //                       Icons.edit,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.all(8.0),
                  //           child: Text(
                  //             "qr_code_image".tr(),
                  //             style: TextStyle(
                  //               fontSize: textSizeTitle,
                  //             ),
                  //           ),
                  //         ),
                  //         Center(
                  //           child: Stack(
                  //             children: [
                  //               Container(
                  //                 width:
                  //                     MediaQuery.of(context).size.height * 0.25,
                  //                 height:
                  //                     MediaQuery.of(context).size.height * 0.3,
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(
                  //                     width: 4,
                  //                     color: Colors.black26,
                  //                   ),
                  //                   // shape: BoxShape.circle,
                  //                 ),
                  //                 child: ClipRRect(
                  //                   // borderRadius: BorderRadius.circular(1000),
                  //                   child: _selectQRCode == null
                  //                       ? Container(
                  //                           width: 80,
                  //                           height: 80,
                  //                           decoration: BoxDecoration(
                  //                             color: Colors.grey,
                  //                           ),
                  //                           child: Center(
                  //                             child: Icon(
                  //                               Icons.camera_alt_outlined,
                  //                               color: Colors.grey[400],
                  //                               size: 30,
                  //                             ),
                  //                           ),
                  //                         )
                  //                       : Image.file(
                  //                           _selectQRCode!,
                  //                           fit: BoxFit.cover,
                  //                         ),
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 bottom: 0,
                  //                 right: 0,
                  //                 child: InkWell(
                  //                   onTap: () {
                  //                     getImageFromGalleryQRCode();
                  //                   },
                  //                   child: Container(
                  //                     width: 40,
                  //                     height: 40,
                  //                     decoration: BoxDecoration(
                  //                       shape: BoxShape.circle,
                  //                       border: Border.all(
                  //                           width: 4,
                  //                           color: Theme.of(context)
                  //                               .scaffoldBackgroundColor),
                  //                       color: Colors.green,
                  //                     ),
                  //                     child: const Icon(
                  //                       Icons.edit,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 20,
            //             vertical: 10,
            //           ),
            //           child: ButtonWidget(
            //             name: "Back",
            //             color: Colors.green,
            //             onClick: () {
            //               if (_controller.page == 0) {
            //                 Navigator.pop(context);
            //               }
            //               _controller.previousPage(
            //                 duration: const Duration(
            //                   milliseconds: 700,
            //                 ),
            //                 curve: Curves.easeInOut,
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 20,
            //             vertical: 10,
            //           ),
            //           child: ButtonWidget(
            //             name: onLastPage == false ? "Next" : "Sign Up Now",
            //             color: primary,
            //             onClick: () {
            //               if (key1.currentState!.validate() ||
            //                   key2.currentState!.validate()) {}
            //               onLastPage == false
            //                   ? _controller.nextPage(
            //                       duration: const Duration(
            //                         milliseconds: 700,
            //                       ),
            //                       curve: Curves.easeIn,
            //                     )
            //                   : create();
            //             },
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  onNextPage() {
    _controller.nextPage(
      duration: const Duration(
        milliseconds: 700,
      ),
      curve: Curves.easeIn,
    );
  }

  create() async {
    setState(() {});
    await EasyLoading.show(status: 'loading...');
    Shop req = Shop();
    req.id = 0;
    req.shopid = "0";
    req.shopName = txtShopName.text;
    req.ownerName = txtShopOwnerName.text;
    req.gender = txtGender.text;
    req.dob = txtDOB.text;
    req.nationality = txtNationality.text;
    req.location = txtLocation.text;
    req.idcard = txtIDCard.text;
    req.phone = txtPhone.text;
    req.password = txtPassword.text;

    req.tokenid = "";

    req.facebookPage = txtFacebookPage.text;
    req.paymentType = txtPaymentType.text;
    req.bankNameid = 0;
    req.accountName = txtAccountName.text;
    req.accountNumber = txtAccountNumber.text;
    req.feetype = "";
    req.feecharge = 0.00;
    req.shophistorydate = txtShopHistoryDate.text;
    req.expiredate = txtExpireDate.text;
    req.note = "";
    req.status = "InActive";

    req.logoShop = logoShop ?? "";
    req.qrCodeImage = qrCode ?? "";

    ShopData().insertShop(req).then((value) async {
      await EasyLoading.showSuccess('Sign up successfully!',
          duration: const Duration(seconds: 2));
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const ShopSignInScreen(),
      //   ),
      // );
      login(txtPhone.text, txtPassword.text);
      createExchangeRate(value.data!.id);
      // Navigator.of(context)
      //   ..pop()
      //   ..pop();
    }).catchError((onError) {
      showErrorMessage("Sign up faild!");
    });
    //}
  }

  login(phone, pass) async {
    EasyLoading.show(status: 'loading...');
    var sharedPre = await SharedPreferences.getInstance();
    SignInReq req = SignInReq();
    Shop shopModel = Shop();

    req.phone = phone;
    req.password = pass;
    req.usertype = "shop";
    req.ostype = "String";
    req.tokenid = "String";
    AuthenticationData().loginUser(req).then((value) async {
      final localStorage = LocalStorage("TOKEN_APP");
      localStorage.setItem("ACCESS_TOKEN", value.toJson());

      var result = await ShopData().getShopById(value.data!.id);
      setState(() {
        shopModel = result.data!;
      });
      sharedPre.setInt(SHOP_ID, shopModel.id ?? 0);
      sharedPre.setString(SHOP_NO, shopModel.shopid ?? "");
      sharedPre.setString(SHOP_NAME, shopModel.shopName ?? "");
      sharedPre.setString(GENDER, shopModel.gender ?? "");
      sharedPre.setString(DOB, shopModel.dob ?? "");
      sharedPre.setString(NATIONALITY, shopModel.nationality ?? "");
      sharedPre.setString(OWNERNAME, shopModel.ownerName ?? "");
      sharedPre.setString(PHONE, shopModel.phone ?? "");
      sharedPre.setString(PASSWORD, shopModel.password ?? "");
      sharedPre.setString(TOKEN_ID, shopModel.tokenid ?? "");
      sharedPre.setString(LOCATION, shopModel.location ?? "");
      sharedPre.setString(LOGO_SHOP, shopModel.logoShop ?? "");
      sharedPre.setString(PAYMENT_TYPE, shopModel.paymentType ?? "");
      sharedPre.setString(QRCODE_IMAGE, shopModel.qrCodeImage ?? "");
      sharedPre.setInt(BANK_NAME_ID, shopModel.bankNameid ?? 0);
      sharedPre.setString(ACCOUNT_NAME, shopModel.accountName ?? "");
      sharedPre.setString(ACCOUNT_NUMBER, shopModel.accountNumber ?? "");
      sharedPre.setString(FEE_TYEPE, shopModel.feetype ?? "");
      sharedPre.setDouble(FEE_CHARGE, shopModel.feecharge ?? 0);
      sharedPre.setString(SHOP_HISTORY_DATE, shopModel.shophistorydate ?? "");
      sharedPre.setString(NOTE, shopModel.note ?? "");
      sharedPre.setString(STATUS, shopModel.status ?? "");
      sharedPre.setString(ID_CARD, shopModel.idcard ?? "");
      sharedPre.setString(EXPIRE_DATE, shopModel.expiredate ?? "");
      sharedPre.setString(FACEBOOK_PAGE, shopModel.facebookPage ?? "");

      await EasyLoading.showSuccess('Login Success!',
          duration: const Duration(seconds: 2));
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreenShop(),
          ),
        );
      });
    }).catchError((onError) {
      showErrorMessage("Invalid username or password!");
    });
  }

  createExchangeRate(shopid) async {
    var sharedPre = await SharedPreferences.getInstance();
    ExchangeRate req = ExchangeRate();
    req.id = 0;
    req.date = "2023-08-01T11:24:05.997014+07:00";
    req.currencyid = 1;
    req.shopid = shopid;
    req.rate = 4000.00;
    ExchangeRateData().insertExchangeRate(req).then((value) async {
      sharedPre.setInt(EXCHANGE_ID, value.data!.id!);
      sharedPre.setDouble(EXCHANGE_RATE, value.data!.rate!);
    });
  }

  String? qrCode;
  void submitQRCode(File file) async {
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
              qrCode = model.filename;
              // ignore: avoid_print
              print(qrCode);
            } else {
              // ignore: avoid_print
              print("Faild");
            }
          },
        );
      },
    );
  }

  String? logoShop;
  void submitLogoShop(File file) async {
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
              logoShop = model.filename;
              // ignore: avoid_print
              print(logoShop);
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

  Future getImageFromGalleryLogoShop() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _selectLogoShop = File(image!.path);
      submitLogoShop(_selectLogoShop!);
    });
  }

  Future getImageFromCamaraLogoShop() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectLogoShop = File(image!.path);
      submitLogoShop(_selectLogoShop!);
    });
  }

  Future getImageFromGalleryQRCode() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _selectQRCode = File(image!.path);
      submitQRCode(_selectQRCode!);
    });
  }

  Future getImageFromCamaraQRCode() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectQRCode = File(image!.path);
      submitQRCode(_selectQRCode!);
    });
  }

  List genderList = ['male'.tr(), 'female'.tr()];
  void buildGender(BuildContext context) {
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
                            "gender".tr(),
                            style: const TextStyle(
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

  List paymentType = ['QR Code'.tr(), 'Bank Account'.tr(), 'Cash'.tr()];
  void buildPaymentMethodList(BuildContext context) {
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
                            "payment_method".tr(),
                            style: const TextStyle(
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
                          itemCount: paymentType.length,
                          itemBuilder: (context, index) {
                            final item = paymentType[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  txtPaymentType.text = item;
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
          //height: MediaQuery.of(context).size.height * 10,
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            initialChildSize: 0.8,
            minChildSize: 0.2,
            maxChildSize: 0.8,
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
                            "payment_method".tr(),
                            style: const TextStyle(
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
                          itemCount: paymentMethondList.length,
                          itemBuilder: (context, index) {
                            final item = paymentMethondList[index];
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
