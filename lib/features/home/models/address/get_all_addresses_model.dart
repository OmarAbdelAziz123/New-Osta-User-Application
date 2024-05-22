class GetAllAddressesModel {
  bool? success;
  String? message;
  List<Result>? result;

  GetAllAddressesModel({this.success, this.message, this.result});

  factory GetAllAddressesModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return GetAllAddressesModel(); // Return empty model if json is null

    List<Result>? result;

    // Check if 'result' key exists and contains a list
    if (json.containsKey('result') && json['result'] is List<dynamic>) {
      var resultList = json['result'] as List<dynamic>;
      result = resultList.map((data) => Result.fromJson(data)).toList();
    }

    return GetAllAddressesModel(
      success: json['success'],
      message: json['message'],
      result: result,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((x) => x.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? street;
  String? apartmentNumber;
  String? floorNumber;
  String? latitude;
  String? longitude;
  String? desc;
  int? isDefault;
  City? city;

  Result({
    this.id,
    this.name,
    this.street,
    this.apartmentNumber,
    this.floorNumber,
    this.latitude,
    this.longitude,
    this.desc,
    this.isDefault,
    this.city,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      name: json['name'],
      street: json['street'],
      apartmentNumber: json['apartment_number'],
      floorNumber: json['floor_number'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      desc: json['desc'],
      isDefault: json['is_default'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['street'] = street;
    data['apartment_number'] = apartmentNumber;
    data['floor_number'] = floorNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['desc'] = desc;
    data['is_default'] = isDefault;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
