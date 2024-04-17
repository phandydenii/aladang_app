// ignore_for_file: file_names

class Shop {
  int? id;
  String? shopid;
  String? shopName;
  String? gender;
  String? dob;
  String? nationality;
  String? ownerName;
  String? phone;
  String? password;
  String? tokenid;
  String? facebookPage;
  String? location;
  String? logoShop;
  String? paymentType;
  String? qrCodeImage;
  int? bankNameid;
  String? accountNumber;
  String? accountName;
  String? feetype;
  double? feecharge;
  String? shophistorydate;
  String? note;
  String? status;
  String? idcard;
  String? expiredate;

  Shop(
      {this.id,
        this.shopid,
        this.shopName,
        this.gender,
        this.dob,
        this.nationality,
        this.ownerName,
        this.phone,
        this.password,
        this.tokenid,
        this.facebookPage,
        this.location,
        this.logoShop,
        this.paymentType,
        this.qrCodeImage,
        this.bankNameid,
        this.accountNumber,
        this.accountName,
        this.feetype,
        this.feecharge,
        this.shophistorydate,
        this.note,
        this.status,
        this.idcard,
        this.expiredate});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopid = json['shopid'];
    shopName = json['shopName'];
    gender = json['gender'];
    dob = json['dob'];
    nationality = json['nationality'];
    ownerName = json['ownerName'];
    phone = json['phone'];
    password = json['password'];
    tokenid = json['tokenid'];
    facebookPage = json['facebookPage'];
    location = json['location'];
    logoShop = json['logoShop'];
    paymentType = json['paymentType'];
    qrCodeImage = json['qrCodeImage'];
    bankNameid = json['bankNameid'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    feetype = json['feetype'];
    feecharge = json['feecharge'];
    shophistorydate = json['shophistorydate'];
    note = json['note'];
    status = json['status'];
    idcard = json['idcard'];
    expiredate = json['expiredate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shopid'] = shopid;
    data['shopName'] = shopName;
    data['gender'] = gender;
    data['dob'] = dob;
    data['nationality'] = nationality;
    data['ownerName'] = ownerName;
    data['phone'] = phone;
    data['password'] = password;
    data['tokenid'] = tokenid;
    data['facebookPage'] = facebookPage;
    data['location'] = location;
    data['logoShop'] = logoShop;
    data['paymentType'] = paymentType;
    data['qrCodeImage'] = qrCodeImage;
    data['bankNameid'] = bankNameid;
    data['accountNumber'] = accountNumber;
    data['accountName'] = accountName;
    data['feetype'] = feetype;
    data['feecharge'] = feecharge;
    data['shophistorydate'] = shophistorydate;
    data['note'] = note;
    data['status'] = status;
    data['idcard'] = idcard;
    data['expiredate'] = expiredate;
    return data;
  }
}