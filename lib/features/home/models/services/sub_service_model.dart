class SubServiceModel {
  bool? success;
  String? message;
  List<Result>? result;

  SubServiceModel({this.success, this.message, this.result});

  SubServiceModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? minPrice;
  int? maxPrice;
  String? type;
  int? serviceId;
  String? createdAt;
  String? updatedAt;

  Result(
      {this.id,
        this.name,
        this.minPrice,
        this.maxPrice,
        this.type,
        this.serviceId,
        this.createdAt,
        this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    type = json['type'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['type'] = this.type;
    data['service_id'] = this.serviceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
