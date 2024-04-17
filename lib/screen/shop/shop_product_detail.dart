import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import '../../utils/data.dart';

class ShopProductDetail extends StatefulWidget {
  const ShopProductDetail({super.key});

  @override
  State<ShopProductDetail> createState() => _ShopProductDetailState();
}

class _ShopProductDetailState extends State<ShopProductDetail> {
  final CarouselController controller = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Product Detail",
          style: TextStyle(color: primary),
        ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CarouselSlider(
                      items: imageList
                          .map(
                            (item) => Image.asset(
                              item["img"],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                          .toList(),
                      carouselController: controller,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: false,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                            setState(() => currentIndex = index),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map(
                      (entry) {
                        return GestureDetector(
                          onTap: () => controller.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 17 : 7,
                            height: 7,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == entry.key
                                    ? primary
                                    : Colors.green),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Beo Play Speaker",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Icon(CupertinoIcons.minus),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text("01",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Icon(CupertinoIcons.plus),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.amber,
                        ),
                        Text(
                          "4.8(230)",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$9000",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "100/200 Unit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description:",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
