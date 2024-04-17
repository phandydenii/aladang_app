import 'package:aladang_app/utils/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("change_language".tr()),
        backgroundColor: primary,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  context.setLocale(const Locale('km', 'KM'));
                  Navigator.pop(context, "KM");
                },
                title: Text("khmer".tr()),
                trailing: "khmer".tr() == "Khmer"
                    ? const Text("")
                    : const Icon(Icons.check),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  context.setLocale(const Locale('en', 'EN'));
                  Navigator.pop(context, "EN");
                },
                title: Text("english".tr()),
                trailing: "khmer".tr() == "Khmer"
                    ? const Icon(Icons.check)
                    : const Text(""),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardBadge extends StatelessWidget {
  CardBadge(
      {Key? key, required this.name, required this.icon, required this.onTap})
      : super(key: key);
  final String name;
  Icon? icon;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
