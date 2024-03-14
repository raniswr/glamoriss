class ModelGetProfile {
  int? status;
  String? message;
  Data? data;

  ModelGetProfile({this.status, this.message, this.data});

  ModelGetProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? memberId;
  String? patientId;
  String? fullname;
  String? phone;
  String? email;
  String? password;
  String? gender;
  String? birthdate;
  bool? isMember;
  int? point;
  int? spendMoney;
  String? memberLevel;
  String? date;
  int? iV;
  String? tokenReminder;
  String? image;
  String? imageId;
  String? address;
  String? otp;

  Data(
      {this.sId,
      this.memberId,
      this.patientId,
      this.fullname,
      this.phone,
      this.email,
      this.password,
      this.gender,
      this.birthdate,
      this.isMember,
      this.point,
      this.spendMoney,
      this.memberLevel,
      this.date,
      this.iV,
      this.tokenReminder,
      this.image,
      this.imageId,
      this.address,
      this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    memberId = json['memberId'];
    patientId = json['patientId'];
    fullname = json['fullname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    isMember = json['isMember'];
    point = json['point'];
    spendMoney = json['spendMoney'];
    memberLevel = json['memberLevel'];
    date = json['date'];
    iV = json['__v'];
    tokenReminder = json['tokenReminder'];
    image = json['image'];
    imageId = json['imageId'];
    address = json['address'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['memberId'] = this.memberId;
    data['patientId'] = this.patientId;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['isMember'] = this.isMember;
    data['point'] = this.point;
    data['spendMoney'] = this.spendMoney;
    data['memberLevel'] = this.memberLevel;
    data['date'] = this.date;
    data['__v'] = this.iV;
    data['tokenReminder'] = this.tokenReminder;
    data['image'] = this.image;
    data['imageId'] = this.imageId;
    data['address'] = this.address;
    data['otp'] = this.otp;
    return data;
  }
}
