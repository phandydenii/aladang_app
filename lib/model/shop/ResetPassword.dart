class ResetPasswordShop {
  String? shopName;
  String? phone;
  String? idcard;
  String? expiredate;
  String? newPassword;
  String? confirmNewPassword;

  ResetPasswordShop(
      {this.shopName,
      this.phone,
      this.idcard,
      this.expiredate,
      this.newPassword,
      this.confirmNewPassword});

  ResetPasswordShop.fromJson(Map<String, dynamic> json) {
    shopName = json['shopName'];
    phone = json['phone'];
    idcard = json['idcard'];
    expiredate = json['expiredate'];
    newPassword = json['newPassword'];
    confirmNewPassword = json['confirmNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopName'] = shopName;
    data['phone'] = phone;
    data['idcard'] = idcard;
    data['expiredate'] = expiredate;
    data['newPassword'] = newPassword;
    data['confirmNewPassword'] = confirmNewPassword;
    return data;
  }
}
