import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aladang_app/helpdata/customer_data.dart';
import 'package:aladang_app/screen/customer/change_password.dart';
import 'package:aladang_app/servies_provider/provider_url.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/auth/SignInRes.dart';
import '../../model/customer/Customer.dart';
import '../../model/upload/UploadFileRes.dart';
import '../language/language_screen.dart';
import '../startup/start_screen.dart';

class CustomerEditProfile extends StatefulWidget {
  const CustomerEditProfile({Key? key}) : super(key: key);
  @override
  State<CustomerEditProfile> createState() => _CustomerEditProfileState();
}

class _CustomerEditProfileState extends State<CustomerEditProfile> {
  TextEditingController txtCustomerName = TextEditingController();
  static final _keyValidationForm = GlobalKey<FormState>();
  TextEditingController currenPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Customer customer = Customer();
  bool isEdit = false;
  String? customeName;
  String? cusname;
  int? cusid;
  void getCustomerById(id) async {
    var result = await CustomerData().getCustomerById(id);
    setState(() {
      customer = result.data!;
    });
  }

  void getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cusname = prefs.getString(CUSTOMER_NAME);
      cusid = prefs.getInt(CUSTOMER_ID);
      getCustomerById(cusid);
    });
  }

  void getSharePre() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      customer.id = sp.getInt(CUSTOMER_ID);
      customer.customerName = sp.getString(CUSTOMER_NAME);
      customer.phone = sp.getString(CUSTOMER_PHONE);
      customer.gender = sp.getString(CUSTOMER_GENDER);
      customer.currentLocation = sp.getString(CUSTOMER_LOCATION);
      customer.password = sp.getString(CUSTOMER_PASSWORD);
      customer.imageProfile = sp.getString(CUSTOMER_IMAGE);
      getCustomerById(sp.getInt(CUSTOMER_ID));
    });
  }

  Timer? _timer;
  @override
  void initState() {
    getSharePre();
    getLogin();
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
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
        automaticallyImplyLeading: false,
        actions: [
          _selectfile != null
              ? TextButton(
                  onPressed: () {
                    updateCustomerImageProfile();
                    getCustomerById(customer.id);
                  },
                  child: Text("save".tr()),
                )
              : const Text(""),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: primary,
                            ),
                          ),
                          width: 150,
                          height: 150,
                          child: customer.imageProfile == null ||
                                  customer.imageProfile == ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: _selectfile == null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.grey[400],
                                              size: 70,
                                            ),
                                          ),
                                        )
                                      : Image.file(
                                          _selectfile!,
                                          fit: BoxFit.cover,
                                        ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: _selectfile == null
                                      ? Image.network(
                                          ProviderUrl.basicUrlWebApi +
                                              customer.imageProfile!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          _selectfile!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                            color: Colors.grey,
                          ),
                          child: IconButton(
                            onPressed: () {
                              getImageFromGallery();
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "$cusname",
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerChangePassword()),
                  ).then(
                    (value) {
                      if (value == true) {
                        setState(() {
                          getCustomerById(cusid);
                        });
                      }
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "change_password".tr(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_right),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LanguageScreen()),
                  ).then(
                    (value) {
                      if (value == "KM") {
                        context.setLocale(const Locale('km', 'KM'));
                      }
                      if (value == "EN") {
                        context.setLocale(const Locale('en', 'EN'));
                      }
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "language".tr(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_right),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: primary),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text("sign_out".tr()),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  update() {
    if (_keyValidationForm.currentState!.validate()) {
      if (newPassword.text == confirmPassword.text) {
        CustomerChangePassReq req = CustomerChangePassReq();
        req.userId = cusid;
        req.currentPassword = currenPassword.text;
        req.newPassword = newPassword.text;

        CustomerData().changeCustomerPassword(req).then((value) {
          setState(() {});
          showSuccessMessage('update_successfully'.tr());
          Navigator.pop(context, true);
        }).catchError((onError) {
          showErrorMessage("Invalid data!");
        });
      }
    }
  }

  updateCustomerImageProfile() {
    if (fileName != null) {
      EasyLoading.show(status: 'loading'.tr());
      Customer req = Customer();

      req.id = customer.id;
      req.customerName = customer.customerName;
      req.phone = customer.phone;
      req.gender = customer.gender;
      req.currentLocation = customer.currentLocation;
      req.password = customer.password;
      req.imageProfile = fileName;
      CustomerData().updateCustomer(req).then((value) async {
        await EasyLoading.showSuccess('update_successfully'.tr(),
            duration: const Duration(seconds: 2));
      }).catchError((onError) {
        showErrorMessage("invalid_data".tr());
        EasyLoading.dismiss();
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

  File? _selectfile;
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

  String? fileName;
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
}
