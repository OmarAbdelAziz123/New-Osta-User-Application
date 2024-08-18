import '../../offer/models/offers/get_all_offers_to_me_model.dart';

class GetOrdersByFilterModel {
  bool? success;
  String? message;
  Result? orderModelList;

  GetOrdersByFilterModel({this.success, this.message, this.orderModelList});

  GetOrdersByFilterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    orderModelList =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (orderModelList != null) {
      data['result'] = orderModelList!.toJson();
    }
    return data;
  }
}

class Result {
  List<OrderModel>? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrderModel>[];
      json['data'].forEach((v) {
        data!.add(OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderModel {
  int? id;
  String? start;
  String? end;
  String? warrantyId;
  String? status;
  String? desc;
  int? price;
  int? unknownProblem;
  int? maxAllowedPrice;
  String? locationLatitude;
  String? locationLongitude;
  String? locationDesc;
  Service? service;
  List<SubServices>? subServices;
  List<String>? images;
  String? voiceDesc;
  int? totalPendingOffers;
  String? distance;
  List<OfferModel>? offers;
  bool? isThereMore;

  OrderModel(
      {this.id,
      this.start,
      this.end,
      this.warrantyId,
      this.status,
      this.desc,
      this.price,
      this.unknownProblem,
      this.maxAllowedPrice,
      this.locationLatitude,
      this.locationLongitude,
      this.locationDesc,
      this.service,
      this.subServices,
      this.images,
      this.voiceDesc,
      this.totalPendingOffers,
      this.distance,
      this.offers,
      this.isThereMore});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    warrantyId = json['warranty_id'];
    status = json['status'];
    desc = json['desc'];
    price = json['price'];
    unknownProblem = json['unknown_problem'];
    maxAllowedPrice = json['max_allowed_price'];
    locationLatitude = json['location_latitude'];
    locationLongitude = json['location_longitude'];
    locationDesc = json['location_desc'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(SubServices.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
    voiceDesc = json['voice_desc'];
    totalPendingOffers = json['total_pending_offers'];
    distance = json['distance'];
    if (json['offers'] != null) {
      offers = <OfferModel>[];
      json['offers'].forEach((v) {
        offers!.add(OfferModel.fromJson(v));
      });
    }
    isThereMore = json['is_there_more'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start'] = start;
    data['end'] = end;
    data['warranty_id'] = warrantyId;
    data['status'] = status;
    data['desc'] = desc;
    data['price'] = price;
    data['unknown_problem'] = unknownProblem;
    data['max_allowed_price'] = maxAllowedPrice;
    data['location_latitude'] = locationLatitude;
    data['location_longitude'] = locationLongitude;
    data['location_desc'] = locationDesc;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (subServices != null) {
      data['sub_services'] = subServices!.map((v) => v.toJson()).toList();
    }
    data['images'] = images;
    data['voice_desc'] = voiceDesc;
    data['total_pending_offers'] = totalPendingOffers;
    data['distance'] = distance;
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    data['is_there_more'] = isThereMore;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['max_price'] = maxPrice;
    data['type'] = type;
    data['quantity'] = quantity;
    return data;
  }
}
