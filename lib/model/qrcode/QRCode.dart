// ignore_for_file: file_names

class QRCode {
  int? id;
  String? qrcode;
  String? createby;
  String? createdate;

  QRCode({this.id, this.qrcode, this.createby, this.createdate});

  QRCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qrcode = json['qrcode'];
    createby = json['createby'];
    createdate = json['createdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['qrcode'] = qrcode;
    data['createby'] = createby;
    data['createdate'] = createdate;
    return data;
  }
}
