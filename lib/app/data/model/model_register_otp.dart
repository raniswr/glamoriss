class ModelRegisterOtp {
  int? status;
  String? message;
  Data? data;

  ModelRegisterOtp({this.status, this.message, this.data});

  ModelRegisterOtp.fromJson(Map<String, dynamic> json) {
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
  String? memberLevel;
  String? sId;
  String? date;
  int? iV;

  Data({this.memberId, this.patientId, this.fullname, this.phone, this.email, this.password, this.gender, this.birthdate, this.isMember, this.point, this.memberLevel, this.sId, this.date, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
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
    memberLevel = json['memberLevel'];
    sId = json['_id'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['memberLevel'] = this.memberLevel;
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}
