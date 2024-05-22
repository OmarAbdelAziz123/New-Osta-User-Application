class GetAllOffersToMeModel {
  bool? success;
  String? message;
  List<Result>? result;

  GetAllOffersToMeModel({this.success, this.message, this.result});

  GetAllOffersToMeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? arrivalTime;
  int? price;
  String? status;
  int? providerId;
  int? orderId;
  String? distance;
  String? createdAt;
  String? updatedAt;
  Provider? provider;

  Result(
      {this.id,
        this.arrivalTime,
        this.price,
        this.status,
        this.providerId,
        this.orderId,
        this.distance,
        this.createdAt,
        this.updatedAt,
        this.provider});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arrivalTime = json['arrival_time'];
    price = json['price'];
    status = json['status'];
    providerId = json['provider_id'];
    orderId = json['order_id'];
    distance = json['distance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arrival_time'] = this.arrivalTime;
    data['price'] = this.price;
    data['status'] = this.status;
    data['provider_id'] = this.providerId;
    data['order_id'] = this.orderId;
    data['distance'] = this.distance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    return data;
  }
}

class Provider {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  bool? isPhoneVerified;
  Country? country;
  Country? city;
  String? gender;
  List<Services>? services;
  BankAccount? bankAccount;
  String? personalMediaUrl;
  String? frontIdMediaUrl;
  String? backIdMediaUrl;
  String? certificateMediaUrl;
  String? token;
  int? totalCompletedOrders;

  Provider(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.isPhoneVerified,
        this.country,
        this.city,
        this.gender,
        this.services,
        this.bankAccount,
        this.personalMediaUrl,
        this.frontIdMediaUrl,
        this.backIdMediaUrl,
        this.certificateMediaUrl,
        this.token,
        this.totalCompletedOrders});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    isPhoneVerified = json['is_phone_verified'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new Country.fromJson(json['city']) : null;
    gender = json['gender'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    bankAccount = json['bank_account'] != null
        ? new BankAccount.fromJson(json['bank_account'])
        : null;
    personalMediaUrl = json['personal_media_url'];
    frontIdMediaUrl = json['front_id_media_url'];
    backIdMediaUrl = json['back_id_media_url'];
    certificateMediaUrl = json['certificate_media_url'];
    token = json['token'];
    totalCompletedOrders = json['total_completed_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['is_phone_verified'] = this.isPhoneVerified;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['gender'] = this.gender;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.bankAccount != null) {
      data['bank_account'] = this.bankAccount!.toJson();
    }
    data['personal_media_url'] = this.personalMediaUrl;
    data['front_id_media_url'] = this.frontIdMediaUrl;
    data['back_id_media_url'] = this.backIdMediaUrl;
    data['certificate_media_url'] = this.certificateMediaUrl;
    data['token'] = this.token;
    data['total_completed_orders'] = this.totalCompletedOrders;
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

class Services {
  int? id;
  String? name;
  String? category;

  Services({this.id, this.name, this.category});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    return data;
  }
}

class BankAccount {
  int? id;
  String? name;
  String? iban;

  BankAccount({this.id, this.name, this.iban});

  BankAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iban'] = this.iban;
    return data;
  }
}
