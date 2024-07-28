class ReceiptModel {
  bool? success;
  String? message;
  Result? result;

  ReceiptModel({this.success, this.message, this.result});

  ReceiptModel.fromJson(Map<String, dynamic> json) {
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
  String? invoiceNumber;
  String? status;
  dynamic? providerCost;
  dynamic? appFess;
  dynamic? discount;
  dynamic? subTotal;
  dynamic? tax;
  dynamic? total;
  String? paymentMethod;
  String? paymentStatus;
  Details? details;
  String? qrCodeContent;
  String? createdAt;
  String? updatedAt;
  Order? order;

  Result(
      {this.id,
        this.invoiceNumber,
        this.status,
        this.providerCost,
        this.appFess,
        this.discount,
        this.subTotal,
        this.tax,
        this.total,
        this.paymentMethod,
        this.paymentStatus,
        this.details,
        this.qrCodeContent,
        this.createdAt,
        this.updatedAt,
        this.order});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    status = json['status'];
    providerCost = json['provider_cost'];
    appFess = json['app_fess'];
    discount = json['discount'];
    subTotal = json['sub_total'];
    tax = json['tax'];
    total = json['total'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    qrCodeContent = json['qr_code_content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['status'] = this.status;
    data['provider_cost'] = this.providerCost;
    data['app_fess'] = this.appFess;
    data['discount'] = this.discount;
    data['sub_total'] = this.subTotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['qr_code_content'] = this.qrCodeContent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Details {
  String? service;
  String? worker;
  String? workingInMinutes;
  String? orderCreatedAt;

  Details(
      {this.service, this.worker, this.workingInMinutes, this.orderCreatedAt});

  Details.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    worker = json['worker'];
    workingInMinutes = json['working_in_minutes'];
    orderCreatedAt = json['order_created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service'] = this.service;
    data['worker'] = this.worker;
    data['working_in_minutes'] = this.workingInMinutes;
    data['order_created_at'] = this.orderCreatedAt;
    return data;
  }
}

class Order {
  int? id;
  String? start;
  String? end;
  String? warrantyId;
  String? status;
  String? desc;
  dynamic? price;
  dynamic? unknownProblem;
  dynamic? maxAllowedPrice;
  String? locationLatitude;
  String? locationLongitude;
  String? locationDesc;
  List<SubServices>? subServices;
  List<String>? images;
  String? distance;

  Order(
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
        this.subServices,
        this.images,
        this.distance});

  Order.fromJson(Map<String, dynamic> json) {
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
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
    distance = json['distance'];
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
    data['location_latitude'] = this.locationLatitude;
    data['location_longitude'] = this.locationLongitude;
    data['location_desc'] = this.locationDesc;
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    return data;
  }
}

class SubServices {
  dynamic? id;
  String? name;
  dynamic? maxPrice;
  String? type;
  dynamic? quantity;

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
