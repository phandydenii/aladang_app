class CustomerResetPasswordReq {
  String? phone;
  String? customerName;
  String? newPassword;

  CustomerResetPasswordReq({this.phone, this.customerName, this.newPassword});

  CustomerResetPasswordReq.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    customerName = json['customerName'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['customerName'] = this.customerName;
    data['newPassword'] = this.newPassword;
    return data;
  }
}
