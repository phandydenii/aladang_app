// ignore_for_file: file_names

class BannerReq {
  int? id;
  String? date;
  String? userid;
  int? shopid;
  String? exireddate;
  int? qtymonth;
  String? bannerimage;
  String? bannerstatus;

  BannerReq(
      {this.id,
      this.date,
      this.userid,
      this.shopid,
      this.exireddate,
      this.qtymonth,
      this.bannerimage,
      this.bannerstatus});

  BannerReq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    userid = json['userid'];
    shopid = json['shopid'];
    exireddate = json['exireddate'];
    qtymonth = json['qtymonth'];
    bannerimage = json['bannerimage'];
    bannerstatus = json['bannerstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['userid'] = userid;
    data['shopid'] = shopid;
    data['exireddate'] = exireddate;
    data['qtymonth'] = qtymonth;
    data['bannerimage'] = bannerimage;
    data['bannerstatus'] = bannerstatus;
    return data;
  }
}
