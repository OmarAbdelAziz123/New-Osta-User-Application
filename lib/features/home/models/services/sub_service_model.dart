class SubServiceModel {
  bool? success;
  String? message;
  List<SubService>? result;

  SubServiceModel({this.success, this.message, this.result});

  SubServiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = <SubService>[];
      json['result'].forEach((v) {
        result!.add(SubService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubService {
  int? id;
  String? name;
  int? maxPrice;
  String? type;
  List<Spaces>? spaces;

  SubService({this.id, this.name, this.maxPrice, this.type, this.spaces});

  SubService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    maxPrice = json['max_price'];
    type = json['type'];
    if (json['spaces'] != null) {
      spaces = <Spaces>[];
      json['spaces'].forEach((v) {
        spaces!.add(Spaces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['max_price'] = maxPrice;
    data['type'] = type;
    if (spaces != null) {
      data['spaces'] = spaces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Spaces {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Spaces({this.id, this.name, this.createdAt, this.updatedAt, this.pivot});

  Spaces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? subServiceId;
  int? spaceId;
  String? maxPrice;

  Pivot({this.subServiceId, this.spaceId, this.maxPrice});

  Pivot.fromJson(Map<String, dynamic> json) {
    subServiceId = json['sub_service_id'];
    spaceId = json['space_id'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_service_id'] = subServiceId;
    data['space_id'] = spaceId;
    data['max_price'] = maxPrice;
    return data;
  }
}
