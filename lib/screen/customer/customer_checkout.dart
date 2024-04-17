import 'package:flutter/material.dart';

import '../../component/button_widget.dart';
import '../../component/input_text.dart';
import '../../utils/constant.dart';

class CustomerCheckOut extends StatefulWidget {
  const CustomerCheckOut({Key? key}) : super(key: key);

  @override
  State<CustomerCheckOut> createState() => _CustomerCheckOutState();
}

class _CustomerCheckOutState extends State<CustomerCheckOut> {
  TextEditingController txtPaymentMethod = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Select Payment Method",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: InputText(
                  name: "Location",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InputText(
                    controller: txtPaymentMethod,
                    name: "Payment method",
                    suffixIcon: const Icon(Icons.filter_list),
                    onTap: () {
                      buildPaymentMethod(context);
                    }),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "1-QR Code Image",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/images/qr.png",
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "2-Bank Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ABA",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Text(
                              "Dy Phand",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Text(
                              "003 456 122",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      name: 'Cancel',
                      onClick: () {},
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: ButtonWidget(
                      name: 'Check Out',
                      onClick: () {},
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buildPaymentMethod(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: DraggableScrollableSheet(
              initialChildSize: 0.23,
              minChildSize: 0.2,
              maxChildSize: 0.75,
              builder: (_, controller) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      //====== header =====
                      Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                        ),
                        child: const Center(
                            child: Text("ជ្រើសរើសយានយន្ត",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: controller,
                          itemCount: 2,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  //txtPaymentMethod.text=
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      // color: Colors.brown,
                                      child: const Center(
                                        child: Text(
                                          "ABA",
                                          style: TextStyle(
                                              color: primary, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                        thickness: 0.5,
                                        height: 0,
                                        color: Colors.grey.shade300),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// void _showAlertDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: Stack(
//           //overflow: Overflow.visible,
//           children: <Widget>[
//             Positioned(
//               right: -40.0,
//               top: -40.0,
//               child: InkResponse(
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   ListView.builder(
//                     itemCount: 5,
//                     itemBuilder: (context, index) {
//                       return const Card(
//                         child: Row(
//                           children: [
//                             Text("Hello"),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
