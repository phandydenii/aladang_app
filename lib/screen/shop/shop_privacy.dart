import 'package:aladang_app/helpdata/privacy_data.dart';
import 'package:aladang_app/model/privacy/Privacy.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShopPrivacy extends StatefulWidget {
  const ShopPrivacy({Key? key}) : super(key: key);

  @override
  State<ShopPrivacy> createState() => _ShopPrivacyState();
}

class _ShopPrivacyState extends State<ShopPrivacy> {
  List<Privacy> privacy = [];
  bool _isLoading = false;

  void getPrivacy() async {
    _isLoading = true;

    var result = await PrivacyData().getPrivacyAll();
    setState(() {
      privacy = result.data!;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getPrivacy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("privacy".tr()),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: _isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          '${privacy[0].description}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
