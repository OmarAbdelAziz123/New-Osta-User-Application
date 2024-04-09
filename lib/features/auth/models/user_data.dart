class UserData {
  bool? success;
  String? message;
  Result? result;

  UserData({this.success, this.message, this.result});

  UserData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? gender;
  Null? token;

  Result({this.id, this.name, this.phone, this.email, this.gender, this.token});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['token'] = this.token ?? '';
    return data;
  }
}
