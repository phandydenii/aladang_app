import 'dart:convert';

import 'package:aladang_app/model/upload/UploadFileRes.dart';
import 'package:easy_localization/easy_localization.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../utils/constant.dart';
import 'package:http/http.dart' as http;

class CustomerUploadReceipt extends StatefulWidget {
  const CustomerUploadReceipt({Key? key}) : super(key: key);

  @override
  State<CustomerUploadReceipt> createState() => _CustomerUploadReceiptState();
}

class _CustomerUploadReceiptState extends State<CustomerUploadReceipt> {
  File? _selectFile;
  String? fileName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Upload Receipt Here",
          style: TextStyle(color: primary),
        ),
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
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.height * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.black26),
                    // shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                      // borderRadius: BorderRadius.circular(1000),
                      child: ClipRRect(
                    // borderRadius: BorderRadius.circular(1000),
                    child: _selectFile == null
                        ? Image.asset("assets/images/no_img.jpg",
                            fit: BoxFit.fill)
                        : ClipRRect(
                            // borderRadius: BorderRadius.circular(1000),
                            child: Image.file(
                              File(_selectFile!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                  )),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: getImageFromGallery,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
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
          ),
          ElevatedButton(
            onPressed: () {
              // submitFile(_selectFile!);
              // print(fileName);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future getImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _selectFile = File(image!.path);
      submitFile(_selectFile!);
    });
  }

  Future getImageFromCamara() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectFile = File(image!.path);
    });
  }

  void submitFile(File file) async {
    fileName = file.path;
    var url = "http://localhost:55131/api/v1/uploadfile/uploadfile";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      child: TextButton(
                    child: Text("$fileName"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      getImageFromGallery();
                    },
                  ));
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      child: TextButton(
                    child: const Text("Image size is big"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      getImageFromGallery();
                    },
                  ));
                },
              );
            }
          },
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> Upload(File file) async {
    String name = file.path.toString();
    String dir = path.dirname(file.path);
    String ex = name.split(".").last;
    String newPath = path.join(
        dir, '${DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now())}.$ex');
    file.renameSync(newPath);

    var stream = http.ByteStream(file.openRead());
    var length = await file.length();
    var url = "http://localhost:55131/api/v1/uploadfile/uploadfile";
    var uri = Uri.parse(url);
    var multiport = http.MultipartFile('file', stream, length);

    var request = http.MultipartRequest('POST', uri);
    request.files.add(multiport);
    var result = request.send();
    if (result.hashCode == 200) {
      // ignore: avoid_print
      print("Uploaded!");
    } else {
      // ignore: avoid_print
      print("Faild");
    }
  }
}
