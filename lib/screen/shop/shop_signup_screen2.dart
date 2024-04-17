import 'package:flutter/material.dart';

import '../../component/button_loading_widget.dart';
import '../../component/button_widget.dart';
import '../../component/input_datetime_widget.dart';
import '../../component/input_passowrd.dart';
import '../../component/input_text.dart';
import '../../utils/constant.dart';

class ShopSignUpScreen2 extends StatefulWidget {
  const ShopSignUpScreen2({Key? key}) : super(key: key);

  @override
  State<ShopSignUpScreen2> createState() => _ShopSignUpScreen2State();
}

class _ShopSignUpScreen2State extends State<ShopSignUpScreen2> {
  static final _keyValidationForm = GlobalKey<FormState>();
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

  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: const Text("Sign Up"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Form(
                  key: _keyValidationForm,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          //Lottie.asset("assets/jsons/business-3.json"),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Welcome Shop',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Sign in to continue',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),

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
                          InputText(
                            controller: txtShopName,
                            name: "Shop Name",
                            //icon: Icons.phone,
                            //isDropdown: false,
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
                              //icon: Icons.phone,
                              //isDropdown: false,
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
                                //buildGender(context);
                              },
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                          ),

                          // "dob": "1998-09-16T00:00:00",
                          InputDateTimeWidget(
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
                              controller: txtNationality,
                              name: "Nationality",
                              //icon: Icons.phone,
                              //isDropdown: false,
                            ),
                          ),

                          // "location":
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtLocation,
                              name: "Address",
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              onTap: () {
                                //buildLocation(context);
                              },
                            ),
                          ),

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
                          PassWordInputText(
                            controller: txtPassword,
                            prefixIcon: const Icon(Icons.lock),
                            name: "Passowrd",
                          ),

                          // "tokenid": "00000000",
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtTokenId,
                              name: "Token ID",
                              //suffixIcon: Icon(Icons.arrow_drop_down),
                              //isDropdown: false,
                              onTap: () {
                                //buildPaymentMethod(context);
                              },
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
                              name: "Facebook Page",
                              //suffixIcon: Icon(Icons.arrow_drop_down),
                              //isDropdown: false,
                              onTap: () {
                                //buildPaymentMethod(context);
                              },
                            ),
                          ),

                          // "logoShop"
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtLogoShop,
                              name: "Logo Shop",
                              //icon: Icons.phone,
                              //isDropdown: false,
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
                              //isDropdown: false,
                              onTap: () {
                                //buildPaymentMethod(context);
                              },
                            ),
                          ),

                          // "qrCodeImage":
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtQrCodeImage,
                              name: "QR Code Image",
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

                          // "accountNumber": "0987654",
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
                          // "accountName": "Zanta",
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

                          // "feecharge": 4.1,
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

                          // "shophistorydate": "2022-07-26T00:00:00",
                          InputDateTimeWidget(
                            name: "Shop History Date",
                            controller: txtShopHistoryDate,
                            prefixIcon: const Icon(Icons.date_range),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            vertical: 10,
                            horizontal: 20,
                          ),

                          // "note": "None",
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtNote,
                              name: "Note",
                            ),
                          ),

                          // "idcard": "00091711",
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtIDCard,
                              name: "Card or Passport",
                              //icon: Icons.phone,
                              //isDropdown: false,
                            ),
                          ),

                          // "expiredate": "2025-01-01T00:00:00"
                          InputDateTimeWidget(
                            name: "Expire Date",
                            controller: txtExpireDate,
                            prefixIcon: const Icon(Icons.date_range),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            vertical: 10,
                            horizontal: 20,
                          ),

                          // Text("Logo Shop"),
                          // Center(
                          //   child: Stack(
                          //     children: [
                          //       Container(
                          //         width:
                          //             MediaQuery.of(context).size.height * 0.2,
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.2,
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //             width: 4,
                          //             color: Colors.black26,
                          //           ),
                          //           // shape: BoxShape.circle,
                          //         ),
                          //         child: ClipRRect(
                          //           // borderRadius: BorderRadius.circular(1000),
                          //           child: Image.asset(
                          //             "assets/images/add-image.png",
                          //             fit: BoxFit.fill,
                          //           ),
                          //         ),
                          //       ),
                          //       Positioned(
                          //         bottom: 0,
                          //         right: 0,
                          //         child: InkWell(
                          //           onTap: () {
                          //
                          //           },
                          //           child: Container(
                          //             width: 40,
                          //             height: 40,
                          //             decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               border: Border.all(
                          //                   width: 4,
                          //                   color: Theme.of(context)
                          //                       .scaffoldBackgroundColor),
                          //               color: Colors.green,
                          //             ),
                          //             child: const Icon(
                          //               Icons.edit,
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Text("QR Code Image"),
                          // Center(
                          //   child: Stack(
                          //     children: [
                          //       Container(
                          //         width:
                          //             MediaQuery.of(context).size.height * 0.2,
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.2,
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //             width: 4,
                          //             color: Colors.black26,
                          //           ),
                          //           // shape: BoxShape.circle,
                          //         ),
                          //         child: ClipRRect(
                          //           // borderRadius: BorderRadius.circular(1000),
                          //           child: Image.asset(
                          //             "assets/images/add-image.png",
                          //             fit: BoxFit.fill,
                          //           ),
                          //         ),
                          //       ),
                          //       Positioned(
                          //         bottom: 0,
                          //         right: 0,
                          //         child: InkWell(
                          //           onTap: () {
                          //             getImageFromGallery();
                          //           },
                          //           child: Container(
                          //             width: 40,
                          //             height: 40,
                          //             decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               border: Border.all(
                          //                   width: 4,
                          //                   color: Theme.of(context)
                          //                       .scaffoldBackgroundColor),
                          //               color: Colors.green,
                          //             ),
                          //             child: const Icon(
                          //               Icons.edit,
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       _selectFile !=null ? Image.file(_selectFile!) : Text("Please select image")
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          name: "Sign In",
                          color: Colors.green,
                          onClick: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: _isLoading == true
                            ? const ButtonLoadingWidget()
                            : ButtonWidget(
                                name: "Sign Up",
                                color: primary,
                                onClick: () {
                                  //create();
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
