import 'package:aladang_app/component/button_widget.dart';
import 'package:aladang_app/helpdata/qrcode_data.dart';
import 'package:aladang_app/helpdata/shop_data.dart';
import 'package:aladang_app/model/shop/ChangeQRCodeImage.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/QRCode/QRCode.dart';
import '../../model/auth/SignInRes.dart';
import '../../model/upload/UploadFileRes.dart';
import '../../servies_provider/provider_url.dart';

class ShopPayMe extends StatefulWidget {
  const ShopPayMe({Key? key, this.isSetting}) : super(key: key);
  final bool? isSetting;
  @override
  State<ShopPayMe> createState() => _ShopPayMeState();
}

class _ShopPayMeState extends State<ShopPayMe> {
  File? _selectFile;

  Future getImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _selectFile = File(image!.path);
      submitFile(_selectFile!);
    });
  }

  String? qrImage;
  int? shopId;
  String? shopName;
  void getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      qrImage = prefs.getString(QRCODE_IMAGE);
      shopName = prefs.getString(SHOP_NAME);
      shopId = prefs.getInt(SHOP_ID);
    });
  }

  @override
  void initState() {
    getLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: widget.isSetting! ? true : false,
        elevation: 0,
        title: Text(
          widget.isSetting == true
              ? "setting".tr() + "payme".tr()
              : "payme".tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: widget.isSetting == true
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("qr_code_image".tr()),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.height * 0.4,
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 4, color: Colors.black26),
                              // shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(1000),
                              child: qrImage == null || qrImage == ""
                                  ? _selectFile == null
                                      ? Center(
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 100,
                                            color: Colors.grey[300],
                                          ),
                                        )
                                      : Image.file(
                                          File(_selectFile!.path),
                                          fit: BoxFit.cover,
                                        )
                                  : Image.network(
                                      ProviderUrl.getImageUrlApi + qrImage!,
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
                                width: 35,
                                height: 35,
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
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "qr_code_image".tr(),
                          style: TextStyle(
                            fontSize: textSizeTitle,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.black26),
                          // shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          child: qrImage == null || qrImage == ""
                              ? _selectFile == null
                                  ? Center(
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 100,
                                        color: Colors.grey[300],
                                      ),
                                    )
                                  : Image.file(
                                      File(_selectFile!.path),
                                      fit: BoxFit.cover,
                                    )
                              : Image.network(
                                  ProviderUrl.getImageUrlApi + qrImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  String? fileName;
  create() {
    setState(() {});
    QRCode req = QRCode();
    req.id = 0;
    req.qrcode = fileName;
    req.createby = "";
    req.createdate = "";
    QRCodeData().insertQRCode(req).then((value) async {
      setState(() {});
      await EasyLoading.showSuccess('Insert data successfully!',
          duration: const Duration(seconds: 2));
    }).catchError((onError) {
      showErrorMessage("Invalid data!");
    });
  }

  updateQR() {
    setState(() {});
    ChangeQRShopReq req = ChangeQRShopReq();
    req.shopid = shopId;
    req.newqrimage = fileName;
    ShopData().changeQRShop(req).then((value) async {
      setState(() {});
      await EasyLoading.showSuccess('Insert data successfully!',
          duration: const Duration(seconds: 2));
    }).catchError((onError) {
      showErrorMessage("Invalid data!");
    });
  }

  void submitFile(File file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ProviderUrl.basicUrlWebApi + ProviderUrl.updloadSingleFileUrl),
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
              updateQR();
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
}
