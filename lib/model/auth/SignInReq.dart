// ignore_for_file: file_names

class SignInReq {
  int? id;
  String? userName;
  String? phone;
  String? password;
  String? token;
  String? usertype;
  String? ostype;
  String? tokenid;
  String? expireddate;

  SignInReq(
      {this.id,
      this.userName,
      this.phone,
      this.password,
      this.token,
      this.usertype,
      this.ostype,
      this.tokenid,
      this.expireddate
      });

 //factory SignInReq.fromJson(Map<String, dynamic> json) {
  factory SignInReq.fromJson(Map<String, dynamic> json) => SignInReq(
    id: json['id'],
    userName : json['userName'],
    phone : json['phone'],
    password : json['password'],
    token : json['token'],
    usertype : json['usertype'],
    ostype : json['ostype'],
    tokenid : json['tokenid'],
    expireddate : json['expireddate'],
  );

Map<String, dynamic> toJson() => {
  
    'id':id,
    'userName':userName,
    'phone':phone,
    'password':password,
    'token':token,
    'usertype':usertype,
    'ostype':ostype,
    'tokenid':tokenid,
    'expireddate':expireddate,
    
  };
}
