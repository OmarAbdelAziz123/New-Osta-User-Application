class GetProfileDataModel {
  bool? success;
  String? message;
  UserData? result;

  GetProfileDataModel({this.success, this.message, this.result});

  GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
    json['result'] != null ? new UserData.fromJson(json['result']) : null;
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

class UserData {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? personalMediaUrl;
  String? token;
  dynamic? countryId;
  Country? country;

  UserData(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.gender,
        this.dateOfBirth,
        this.personalMediaUrl,
        this.token,
        this.countryId,
        this.country});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    personalMediaUrl = json['personal_media_url'];
    token = json['token'];
    countryId = json['country_id'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['personal_media_url'] = this.personalMediaUrl;
    data['token'] = this.token;
    data['country_id'] = this.countryId;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
