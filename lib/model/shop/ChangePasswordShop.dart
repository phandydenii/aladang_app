// ignore_for_file: file_names

class ChangePaswordShop {
  int? shopid;
  String? phone;
  String? currentPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePaswordShop(
      {this.shopid,
      this.phone,
      this.currentPassword,
      this.newPassword,
      this.confirmNewPassword});

  ChangePaswordShop.fromJson(Map<String, dynamic> json) {
    shopid = json['shopid'];
    phone = json['phone'];
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
    confirmNewPassword = json['confirmNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopid'] = shopid;
    data['phone'] = phone;
    data['currentPassword'] = currentPassword;
    data['newPassword'] = newPassword;
    data['confirmNewPassword'] = confirmNewPassword;
    return data;
  }
}
