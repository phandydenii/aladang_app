import 'dart:convert';
import 'dart:io';
import 'package:aladang_app/helpdata/banner_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:aladang_app/component/input_datetime_widget.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/input_text.dart';
import '../../model/auth/SignInRes.dart';
import '../../model/banner/Banner.dart';
import '../../model/upload/UploadFileRes.dart';
import '../../servies_provider/provider_url.dart';

// ignore: must_be_immutable
class ShopBannerAddScreen extends StatefulWidget {
  ShopBannerAddScreen({Key? key, required this.banner}) : super(key: key);
  BannerReq? banner;
  @override
  State<ShopBannerAddScreen> createState() => _ShopBannerAddScreenState();
}

class _ShopBannerAddScreenState extends State<ShopBannerAddScreen> {
  static final key = GlobalKey<FormState>();
  TextEditingController expireDate = TextEditingController();
  TextEditingController qtymonth = TextEditingController();

  File? _selectFile;

  BannerReq banner = BannerReq();

  int? shopid;
  void getLogint() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopid = prefs.getInt(SHOP_ID);
    });
  }

  @override
  void initState() {
    getLogint();
    if (widget.banner != null) {
      banner = widget.banner!;
      expireDate.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(banner.exireddate!));
      qtymonth.text = banner.qtymonth.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          widget.banner == null
              ? "create".tr() + "banner".tr()
              : "update".tr() + "banner".tr(),
          style: TextStyle(color: primary),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.banner == null ? create() : update();
            },
            child: Text(
              widget.banner == null ? "save".tr() : "update".tr(),
              style: const TextStyle(color: primary),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              InputDateTimeWidget(
                controller: expireDate,
                name: "expire_date".tr(),
                prefixIcon: const Icon(Icons.date_range),
                suffixIcon: const Icon(Icons.arrow_drop_down),
                vertical: 10,
                horizontal: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: InputText(
                  controller: qtymonth,
                  name: "qty_month".tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "banner_image".tr(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: primary,
                              ),
                              // shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(1000),
                              child: _selectFile == null
                                  ? banner.bannerimage == null ||
                                          banner.bannerimage == ""
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
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
                                      : Image.network(
                                          ProviderUrl.getImageUrlApi +
                                              banner.bannerimage!,
                                          fit: BoxFit.cover,
                                        )
                                  : Image.file(
                                      _selectFile!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                getImageFromGallery();
                              },
                              child: Container(
                                width: 50,
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
            ],
          ),
        ),
      ),
    );
  }

  create() {
    if (key.currentState!.validate()) {
      EasyLoading.show(status: 'loading...');
      BannerReq req = BannerReq();
      req.id = 0;
      req.date = "2023-08-23T17:28:59.682062+07:00";
      req.userid = shopid.toString();
      req.shopid = shopid;
      req.exireddate = expireDate.text;
      req.qtymonth = int.parse(qtymonth.text);
      req.bannerimage = fileName;
      req.bannerstatus = "New";
      BannerData().insertBanner(req).then((value) async {
        await EasyLoading.showSuccess('Banner has been create!',
            duration: const Duration(seconds: 2));
        Navigator.pop(context, true);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
      });
    }
  }

  update() {
    if (key.currentState!.validate()) {
      EasyLoading.show(status: 'loading...');
      BannerReq req = BannerReq();
      req.id = widget.banner!.id;
      req.date = "2023-08-23T17:28:59.682062+07:00";
      req.userid = shopid.toString();
      req.shopid = shopid;
      req.exireddate = expireDate.text;
      req.qtymonth = int.parse(qtymonth.text);
      req.bannerimage = fileName ?? widget.banner!.bannerimage;
      req.bannerstatus = "New";
      BannerData().updateBanner(req).then((value) async {
        await EasyLoading.showSuccess('Banner has been update!',
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

  Future getImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _selectFile = File(image!.path);
      submitLogoShop(_selectFile!);
    });
  }

  String? fileName;
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
}
