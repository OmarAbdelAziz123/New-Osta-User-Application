class GetOrdersByFilterModel {
  bool? success;
  Null? message;
  Result? result;

  GetOrdersByFilterModel({this.success, this.message, this.result});

  GetOrdersByFilterModel.fromJson(Map<String, dynamic> json) {
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
  List<Data>? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  Null? start;
  Null? end;
  String? warrantyId;
  String? status;
  Null? desc;
  int? price;
  int? unknownProblem;
  int? maxAllowedPrice;
  Service? service;
  List<SubServices>? subServices;
  List<String>? images;
  int? totalPendingOffers;

  Data(
      {this.id,
        this.start,
        this.end,
        this.warrantyId,
        this.status,
        this.desc,
        this.price,
        this.unknownProblem,
        this.maxAllowedPrice,
        this.service,
        this.subServices,
        this.images,
        this.totalPendingOffers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    warrantyId = json['warranty_id'];
    status = json['status'];
    desc = json['desc'];
    price = json['price'];
    unknownProblem = json['unknown_problem'];
    maxAllowedPrice = json['max_allowed_price'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
    totalPendingOffers = json['total_pending_offers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start'] = this.start;
    data['end'] = this.end;
    data['warranty_id'] = this.warrantyId;
    data['status'] = this.status;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['unknown_problem'] = this.unknownProblem;
    data['max_allowed_price'] = this.maxAllowedPrice;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    data['images'] = this.images;
    data['total_pending_offers'] = this.totalPendingOffers;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? category;

  Service({this.id, this.name, this.category});

  Service.fromJson(Map<String, dynamic> json) {
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

class SubServices {
  int? id;
  String? name;
  int? maxPrice;
  String? type;
  int? quantity;

  SubServices({this.id, this.name, this.maxPrice, this.type, this.quantity});

  SubServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    maxPrice = json['max_price'];
    type = json['type'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['max_price'] = this.maxPrice;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    return data;
  }
}
