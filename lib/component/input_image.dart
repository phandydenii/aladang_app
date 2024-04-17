
import 'package:flutter/material.dart';

class InputImageWidget extends StatefulWidget {
 const InputImageWidget({Key? key}) : super(key: key);
  // double? height;
  // double? width;
  @override
  State<InputImageWidget> createState() => _InputImageWidgetState();
}

class _InputImageWidgetState extends State<InputImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            // width:widget.width,
            // height:widget.height,
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: Colors.black26,
              ),
            ),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(1000),
              child: Image.asset(
                "assets/images/add-image.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {

              },
              child: Container(
                width: 40,
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
    );
  }
}
