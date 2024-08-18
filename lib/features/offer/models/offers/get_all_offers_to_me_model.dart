class GetAllOffersToMeModel {
  bool? success;
  String? message;
  List<OfferModel>? offersList;

  GetAllOffersToMeModel({this.success, this.message, this.offersList});

  GetAllOffersToMeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      offersList = <OfferModel>[];
      json['result'].forEach((v) {
        offersList!.add(OfferModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (offersList != null) {
      data['result'] = offersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferModel {
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

  OfferModel(
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

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arrivalTime = json['arrival_time'];
    price = json['price'];
    status = json['status'];
    providerId = json['provider_id'];
    orderId = json['order_id'];
    distance = json['distance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arrival_time'] = arrivalTime;
    data['price'] = price;
    data['status'] = status;
    data['provider_id'] = providerId;
    data['order_id'] = orderId;
    data['distance'] = distance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (provider != null) {
      data['provider'] = provider!.toJson();
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
        json['country'] != null ? Country.fromJson(json['country']) : null;
    city = json['city'] != null ? Country.fromJson(json['city']) : null;
    gender = json['gender'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    bankAccount = json['bank_account'] != null
        ? BankAccount.fromJson(json['bank_account'])
        : null;
    personalMediaUrl = json['personal_media_url'];
    frontIdMediaUrl = json['front_id_media_url'];
    backIdMediaUrl = json['back_id_media_url'];
    certificateMediaUrl = json['certificate_media_url'];
    token = json['token'];
    totalCompletedOrders = json['total_completed_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['is_phone_verified'] = isPhoneVerified;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['gender'] = gender;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (bankAccount != null) {
      data['bank_account'] = bankAccount!.toJson();
    }
    data['personal_media_url'] = personalMediaUrl;
    data['front_id_media_url'] = frontIdMediaUrl;
    data['back_id_media_url'] = backIdMediaUrl;
    data['certificate_media_url'] = certificateMediaUrl;
    data['token'] = token;
    data['total_completed_orders'] = totalCompletedOrders;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iban'] = iban;
    return data;
  }
}
