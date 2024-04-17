import 'dart:convert';
import 'package:aladang_app/model/shop/ChangeLogoShop.dart';
import 'package:aladang_app/screen/shop/shop_edit_profile.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../helpdata/shop_data.dart';
import '../../model/auth/SignInRes.dart';
import '../../model/shop/Shop.dart';
import 'package:http/http.dart' as http;

import '../../model/upload/UploadFileRes.dart';

class ShopProfile extends StatefulWidget {
  const ShopProfile({Key? key}) : super(key: key);
  @override
  State<ShopProfile> createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  static final _keyValidationForm = GlobalKey<FormState>();
  TextEditingController currenPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool _isLoading = false;
  File? _selectFile;
  String? fileName;
  int? cusid;

  Shop shopsp = Shop();
  void getLogint() async {
    final SharedPreferences sharedPre = await SharedPreferences.getInstance();
    setState(() {
      getShopById(sharedPre.getInt(SHOP_ID));
    });
  }

  void getShopById(id) async {
    print(id);
    _isLoading = true;
    var result = await ShopData().getShopById(id);
    setState(() {
      shopsp = result.data!;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getLogint();
    super.initState();
  }

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "profile".tr(),
          style: TextStyle(color: primary),
        ),
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          onPressed: () {
            //Navigator.pop(context);
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primary,
          ),
        ),
        actions: [
          _selectFile != null
              ? TextButton(
                  onPressed: () {
                    updateLogoShop();
                    //submitFile(_selectFile!);
                  },
                  child: Text("save".tr()),
                )
              : const Text(""),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                //bottom: 0,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: shopsp.logoShop == null || shopsp.logoShop == ""
                          ? _selectFile == null
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: primary,
                                    ),
                                  ),
                                  width: 170,
                                  height: 170,
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey[400],
                                      size: 50,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.green,
                                    ),
                                  ),
                                  width: 170,
                                  height: 170,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File(_selectFile!.path),
                                      //fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: primary,
                                ),
                              ),
                              width: 170,
                              height: 170,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: _selectFile == null
                                    ? Image.network(
                                        ProviderUrl.getImageUrlApi +
                                            shopsp.logoShop!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(_selectFile!.path),
                                        //fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3,
                            color: Colors.green,
                          ),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            getImageFromGallery();
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              shopsp.shopName ?? "",
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              shopsp.location ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Shop Information"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopEditProfile(
                              titleid: 1,
                              shop: shopsp,
                            ),
                          ),
                        ).then(
                          (value) {
                            if (value == true) {
                              setState(() {
                                getShopById(shopsp.id!);
                              });
                            }
                          },
                        );
                      },
                      child: const Text("Edit"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Shop ID",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${shopsp.id}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Shop Name",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${shopsp.shopName}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Shop Owner Name",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${shopsp.ownerName}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Gender",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.gender ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date of Birth",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.dob == "" || shopsp.dob == null
                                    ? ""
                                    : DateFormat('yyyy-MM-dd')
                                        .format(DateTime.parse(shopsp.dob!)),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Nationality",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.nationality ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Divider(
                        //   thickness: 1,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       "Location",
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     Text(
                        //       shopsp.location!.length > 50
                        //           ? '${shopsp.location!.substring(0, 45)}...'
                        //           : shopsp.location ?? "",
                        //       style: const TextStyle(
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "ID Card",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.idcard ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Facebook Page",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.facebookPage ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Note",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.note ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Password & Security"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopEditProfile(
                                titleid: 2,
                                shop: shopsp,
                              ),
                            ),
                          ).then(
                            (value) {
                              if (value == true) {
                                setState(() {
                                  getShopById(shopsp.id!);
                                });
                              }
                            },
                          );
                        },
                        child: const Text("Edit"),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "Password & Security",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Payment"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopEditProfile(
                              titleid: 3,
                              shop: shopsp,
                            ),
                          ),
                        ).then(
                          (value) {
                            if (value == true) {
                              setState(() {
                                getShopById(shopsp.id!);
                              });
                            }
                          },
                        );
                      },
                      child: const Text("Edit"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Payment Type",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${shopsp.paymentType}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Bank Name",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${shopsp.bankNameid}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Account Name",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${shopsp.accountName}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Account Number",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${shopsp.accountNumber}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Fee Type",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.feetype == null
                                    ? ""
                                    : "${shopsp.feetype}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Fee Charge",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.feecharge == null
                                    ? ""
                                    : "${shopsp.feecharge}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Expire Date",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                shopsp.expiredate == null
                                    ? ""
                                    : DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(shopsp.expiredate!)),
                                style: const TextStyle(
                                  fontSize: 16,
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
            ],
          ),
        ),
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

  updateShop(logo) {
    setState(() {
      _isLoading = true;
    });
    Shop req = Shop();
    req.id = shopsp.id;
    req.shopid = shopsp.shopid;
    req.shopName = shopsp.shopName;
    req.ownerName = shopsp.ownerName;
    req.gender = shopsp.gender;
    req.dob = shopsp.dob;
    req.nationality = shopsp.nationality;
    req.location = shopsp.location;
    req.idcard = shopsp.idcard;
    req.facebookPage = shopsp.facebookPage;
    req.note = shopsp.note;
    req.phone = shopsp.phone;
    req.password = shopsp.password;
    req.tokenid = shopsp.tokenid;
    req.logoShop = logo;
    req.paymentType = shopsp.paymentType;
    req.qrCodeImage = shopsp.qrCodeImage;
    req.bankNameid = shopsp.bankNameid;
    req.accountName = shopsp.accountName;
    req.accountNumber = shopsp.accountNumber;
    req.feetype = shopsp.feetype;
    req.feecharge = shopsp.feecharge;
    req.shophistorydate = shopsp.shophistorydate;
    req.status = shopsp.status;
    req.expiredate = shopsp.expiredate;

    ShopData().updateShop(req).then((value) {
      setState(() {
        _isLoading = false;
        getShopById(req.id);
      });
      showSuccessMessage("Update data successfully!");
      // Navigator.pop(context, true);
    }).catchError((onError) {
      showErrorMessage("Invalid data!");
      _isLoading = false;
    });
  }

  updateLogoShop() {
    if (fileName != null) {
      EasyLoading.show(status: 'loading...');
      ChangeLogoShopReq req = ChangeLogoShopReq();
      req.shopid = shopsp.id;
      req.newlogo = fileName;
      ShopData().changeLogoShop(req).then((value) async {
        await EasyLoading.showSuccess('Update logo success!',
            duration: const Duration(seconds: 2));
        getShopById(shopsp.id);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
        EasyLoading.dismiss();
        _isLoading = false;
      });
    }
  }
}
