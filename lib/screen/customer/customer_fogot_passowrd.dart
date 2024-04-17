import 'package:flutter/material.dart';

class CustomerForgotPassword extends StatefulWidget {
  const CustomerForgotPassword({Key? key}) : super(key: key);

  @override
  State<CustomerForgotPassword> createState() => _CustomerForgotPasswordState();
}

class _CustomerForgotPasswordState extends State<CustomerForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fogot Password"),
      ),
    );
  }
}
