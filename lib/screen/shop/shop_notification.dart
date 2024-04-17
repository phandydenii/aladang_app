import 'package:aladang_app/helpdata/location_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../model/location/Location.dart';
import '../../utils/constant.dart';
import '../../utils/data.dart';

class ShopNotification extends StatefulWidget {
  const ShopNotification({Key? key}) : super(key: key);
  @override
  State<ShopNotification> createState() => _ShopNotificationState();
}

class _ShopNotificationState extends State<ShopNotification> {
  static final _key = GlobalKey<FormState>();

  List<Location> locationList = [];
  ScrollController sc = ScrollController();
  int page = 1;

  void getLocationList(int page) async {
    var result = await LocationData().getLocationList(page);
    setState(() {
      locationList = result.data!;
      page++;
    });
  }

  bool? more = false;
  String txtmore = "";

  @override
  void initState() {
    getLocationList(page);
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        getLocationList(page);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notification".tr()),
        backgroundColor: primary,
      ),
      body: ListView.builder(
        itemCount: getStartList.length,
        itemBuilder: (context, index) {
          final itemlist = getStartList[index];
          return Stack(
            children: [
              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${itemlist["title"]}',
                            style: const TextStyle(
                              fontSize: textSizeTitle,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${itemlist["description"]}',
                            style: const TextStyle(
                              fontSize: textSize,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      more = !more!;
                      txtmore = "more${itemlist["id"]}";
                      print(txtmore);
                    });
                  },
                  child: Text(more == true ? "more" : "less"),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  create() {
    if (_key.currentState!.validate()) {
      setState(() {});
      Location req = Location();
      req.id = 0;

      LocationData().insertLocation(req).then((value) {
        setState(() {});
        showSuccessMessage("Insert data successfully!");
        Navigator.pop(context, true);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
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
}
