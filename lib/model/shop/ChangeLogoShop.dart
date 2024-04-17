class ChangeLogoShopReq {
  int? shopid;
  String? newlogo;

  ChangeLogoShopReq({this.shopid, this.newlogo});

  ChangeLogoShopReq.fromJson(Map<String, dynamic> json) {
    shopid = json['shopid'];
    newlogo = json['newlogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopid'] = this.shopid;
    data['newlogo'] = this.newlogo;
    return data;
  }
}
