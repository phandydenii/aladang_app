import 'package:aladang_app/component/button_widget.dart';
import 'package:aladang_app/component/input_datetime_widget.dart';
import 'package:aladang_app/helpdata/shop_data.dart';
import 'package:aladang_app/screen/shop/shop_signin_screen.dart';
import 'package:flutter/material.dart';
import '../../component/button_loading_widget.dart';
import '../../component/input_text.dart';
import '../../component/input_passowrd.dart';
import '../../helpdata/location_data.dart';
import '../../model/location/Location.dart';
import '../../model/shop/Shop.dart';
import '../../utils/constant.dart';

class ShopSignUpScreen1 extends StatefulWidget {
  const ShopSignUpScreen1({Key? key}) : super(key: key);

  @override
  State<ShopSignUpScreen1> createState() => _ShopSignUpScreen1State();
}

class _ShopSignUpScreen1State extends State<ShopSignUpScreen1> {
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
  bool _isLoading = false;

  List<Location> locationList = [];

  void getLocationAllList() async {
    _isLoading = true;
    var result = await LocationData().getLocationAllList();
    setState(() {
      locationList = result.data!;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getLocationAllList();
    super.initState();
  }

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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: InputText(
                              controller: txtShopName,
                              name: "Shop Name",
                              //icon: Icons.phone,
                              //isDropdown: false,
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
                                buildGender(context);
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
                                buildLocation(context);
                              },
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
                                buildPaymentMethod(context);
                              },
                            ),
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
                                buildPaymentMethod(context);
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
                            vertical: 20,
                            horizontal: 10,
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
                                  create();
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

  create() {
    // if (_keyValidationForm.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });
    Shop req = Shop();
    req.id = 0;
    req.shopid = txtShopId.text;
    req.shopName = txtShopName.text;
    req.gender = txtGender.text;
    req.dob = txtDOB.text;
    req.nationality = txtNationality.text;
    req.ownerName = txtShopOwnerName.text;
    req.phone = txtPhone.text;
    req.password = txtPassword.text;
    req.tokenid = txtShopId.text;
    req.facebookPage = txtFacebookPage.text;
    req.location = txtLocation.text;
    req.logoShop = "aba_2022_12_19_17_18_02.png";
    req.paymentType = txtPaymentType.text;
    req.qrCodeImage = "aba_2022_12_19_17_18_02.png";
    req.bankNameid = 1;
    req.accountName = "DY";
    req.accountNumber = "12345";
    req.feetype = "Test";
    req.feecharge = double.parse(txtFeeCharge.text);
    req.shophistorydate = "2023-08-02T03:28:35.234Z";
    req.idcard = "D010";
    req.expiredate = txtExpireDate.text;
    req.note = "Note";
    req.status = "Inactive";

    ShopData().insertShop(req).then((value) {
      setState(() {
        _isLoading = false;
      });
      showSuccessMessage("Insert data successfully!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ShopSignInScreen(),
        ),
      );
    }).catchError((onError) {
      _isLoading = false;
      showErrorMessage("Invalid data!");
    });
    //}
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

  // Future getImageFromGallery() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //   });
  // }

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

  List paymentMethodList = ['ABA', 'ACLEDA', 'Other'];
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
                          itemCount: paymentMethodList.length,
                          itemBuilder: (context, index) {
                            final item = paymentMethodList[index];
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
}
