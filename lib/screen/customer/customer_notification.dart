import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/data.dart';

class CustomerNotification extends StatefulWidget {
  const CustomerNotification({Key? key}) : super(key: key);

  @override
  State<CustomerNotification> createState() => _CustomerNotificationState();
}

class _CustomerNotificationState extends State<CustomerNotification> {
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
          return Card(
            color: Colors.grey[300],
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
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${itemlist["description"]}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
