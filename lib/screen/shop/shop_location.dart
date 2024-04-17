import 'dart:io';
import 'package:aladang_app/component/button_widget.dart';
import 'package:aladang_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../component/input_text.dart';
import '../../helpdata/location_data.dart';
import '../../model/location/Location.dart';

class ShopLocation extends StatefulWidget {
 const ShopLocation({Key? key,  this.locationModel}) : super(key: key);
  final Location? locationModel;
  @override
  State<ShopLocation> createState() => _ShopLocationState();
}

class _ShopLocationState extends State<ShopLocation> {
  static final _keyValidationForm = GlobalKey<FormState>();
  final TextEditingController _txtLocationName = TextEditingController();
  final TextEditingController _txtActive = TextEditingController();
  //final ImagePicker _picker = ImagePicker();
  //XFile? _imageFile;
  File? _selectFile;

  Location item = Location();
  @override
  void initState() {
    if (widget.locationModel != null) {
      item = widget.locationModel!;
      _txtLocationName.text = item.location!;
      _txtActive.text = item.active!;
    }
    super.initState();
  }

  ////========
  void uploadImage() async {
    var headers1 = {'Authorization': "", "Content-type": "multipart/form-data"};
    var url = "http://localhost:55131/api/v1/uploadfile/uploadfile";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headers = headers1;
    var pc = http.MultipartFile.fromBytes('images',
        (await rootBundle.load('assets/images/1.png')).buffer.asUint8List(),
        filename: '1.png');
    request.files.add(pc);
    request.files.add(
      await http.MultipartFile.fromPath(
        'imagesUpload',
        _selectFile!.path,
      ),
    );
    var result = await request.send();
    if (result.statusCode == 200) {
      // ignore: avoid_print
      print("Succesffuly");
    }
    request.headers.addAll(headers);

    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          // ignore: avoid_print
          print("Successfully!");
        } else {
          // ignore: avoid_print
          print("Faild!");
        }
      });
    }).catchError((err) {});
  }

  ///==
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.locationModel == null
              ? "Add Location"
              : "Update Location"),
          backgroundColor: primary,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _keyValidationForm,
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.height * 0.25,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Colors.black26,
                            ),
                            // shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(1000),
                            child: _selectFile == null
                                ? Image.asset(
                                    "assets/images/add-image.png",
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    _selectFile!,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              getImageFromGallery();
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
                        ),
                        // _selectFile != null
                        //     ? Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Image.file(
                        //           _selectFile!,
                        //         ),
                        //       )
                        //     : Text("Please select image")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: InputText(
                      name: 'Location Name',
                      controller: _txtLocationName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: InputText(
                      name: 'Active',
                      controller: _txtActive,
                    ),
                  ),
                  ButtonWidget(
                    name: widget.locationModel == null ? "Save" : "Update",
                    color: primary,
                    onClick: () {
                      uploadImage();
                      //widget.locationModel == null ? create() : update();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future getImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _selectFile = File(image!.path);
      //_imageFile == XFile(image!.path);
    });
  }

  create() {
    if (_keyValidationForm.currentState!.validate()) {
      setState(() {
      });
      Location req = Location();
      req.id = 0;
      req.location = _txtLocationName.text;
      req.active = _txtActive.text;

      LocationData().insertLocation(req).then((value) {
        setState(() {
        });
        showSuccessMessage("Insert data successfully!");
        Navigator.pop(context, true);
      }).catchError((onError) {
        showErrorMessage("Invalid data!");
      });
    }
  }

  update() {
    if (_keyValidationForm.currentState!.validate()) {
      setState(() {
      });
      Location req = Location();
      req.id = item.id;
      req.location = _txtLocationName.text;
      req.active = _txtActive.text;

      LocationData().updateLocation(req).then((value) {
        setState(() {
        });
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
