class ChangeQRShopReq {
  int? shopid;
  String? newqrimage;

  ChangeQRShopReq({this.shopid, this.newqrimage});

  ChangeQRShopReq.fromJson(Map<String, dynamic> json) {
    shopid = json['shopid'];
    newqrimage = json['newqr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopid'] = this.shopid;
    data['newqr'] = this.newqrimage;
    return data;
  }
}
