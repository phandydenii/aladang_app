import 'dart:convert';
import 'dart:io';
import 'package:aladang_app/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../model/auth/SignInRes.dart';
import '../model/upload/UploadFileRes.dart';
import '../servies_provider/provider_url.dart';

class SubmitFile {
  Future<String> submitSingleFile(File file) async {
    String? fileName;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ProviderUrl.updloadSingleFileUrl),
    );
    var headers1 = headerWithToken(getToken());
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
              //print("Success");
            } else {
              //print("Faild");
            }
          },
        );
      },
    );
    return fileName!;
  }

  String getToken() {
    final localStorage = LocalStorage("TOKEN_APP");
    var accessToken = localStorage.getItem("ACCESS_TOKEN");
    SignInRes loginRes = SignInRes.fromJson(accessToken);
    return loginRes.data!.token!;
  }
}
