class ModelUser {
  String? token;
  String? memberId;
  String? patientId;
  String? id;
  String? fullname;
  String? email;
  String? phone;
  String? lokasi;
  bool? isLogin;

  ModelUser({this.token, this.memberId, this.patientId, this.id, this.fullname, this.email, this.phone, this.lokasi, this.isLogin});

  ModelUser.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    memberId = json['memberId'];
    patientId = json['patientId'];
    id = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    lokasi = json['lokasi'];
    isLogin = json['isLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['memberId'] = memberId;
    data['patientId'] = patientId;
    data['_id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['phone'] = phone;
    data['lokasi'] = lokasi;
    data['isLogin'] = isLogin;
    return data;
  }
}
