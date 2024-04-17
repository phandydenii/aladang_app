// ignore_for_file: file_names

class Customer {
  int? id;
  String? date;
  String? phone;
  String? tokenid;
  String? currentLocation;
  String? customerName;
  String? gender;
  String? imageProfile;
  String? password;

  Customer(
      {this.id,
      this.date,
      this.phone,
      this.tokenid,
      this.currentLocation,
      this.customerName,
      this.gender,
      this.imageProfile,
      this.password});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    phone = json['phone'];
    tokenid = json['tokenid'];
    currentLocation = json['currentLocation'];
    customerName = json['customerName'];
    gender = json['gender'];
    imageProfile = json['imageProfile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['phone'] = phone;
    data['tokenid'] = tokenid;
    data['currentLocation'] = currentLocation;
    data['customerName'] = customerName;
    data['gender'] = gender;
    data['imageProfile'] = imageProfile;
    data['password'] = password;
    return data;
  }
}

class CustomerChangePassReq {
  int? userId;
  String? currentPassword;
  String? newPassword;

  CustomerChangePassReq({
    this.userId,
    this.currentPassword,
    this.newPassword,
  });

  CustomerChangePassReq.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['userId'] = userId;
    data['currentPassword'] = currentPassword;
    data['newPassword'] = newPassword;
    return data;
  }
}
