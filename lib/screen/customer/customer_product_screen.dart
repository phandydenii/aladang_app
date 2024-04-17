
import 'package:flutter/material.dart';


class CustomerProductScreen extends StatefulWidget {
  const CustomerProductScreen({Key? key}) : super(key: key);

  @override
  State<CustomerProductScreen> createState() => _CustomerProductScreenState();
}

class _CustomerProductScreenState extends State<CustomerProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEst"),
      ),
    );
  }
}
