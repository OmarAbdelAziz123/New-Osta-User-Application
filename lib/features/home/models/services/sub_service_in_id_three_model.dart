class SubServiceInIdThreeModel {
  bool? success;
  String? message;
  Result? result;

  SubServiceInIdThreeModel({ this.success,  this.message,  this.result});

  factory SubServiceInIdThreeModel.fromJson(Map<String, dynamic> json) {
    return SubServiceInIdThreeModel(
      success: json['success'],
      message: json['message'],
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  List<FixList> fixList;
  List<NewList> newList;

  Result({required this.fixList, required this.newList});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      fixList: (json['fix'] as List).map((i) => FixList.fromJson(i)).toList(),
      newList: (json['new'] as List).map((i) => NewList.fromJson(i)).toList(),
    );
  }
}

class FixList {
  int id;
  String name;
  double minPrice;
  double maxPrice;
  String type;
  int serviceId;
  DateTime createdAt;
  DateTime updatedAt;

  FixList({
    required this.id,
    required this.name,
    required this.minPrice,
    required this.maxPrice,
    required this.type,
    required this.serviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FixList.fromJson(Map<String, dynamic> json) {
    return FixList(
      id: json['id'],
      name: json['name'],
      minPrice: json['min_price'].toDouble(),
      maxPrice: json['max_price'].toDouble(),
      type: json['type'],
      serviceId: json['service_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class NewList {
  int id;
  String name;
  double minPrice;
  double maxPrice;
  String type;
  int serviceId;
  DateTime createdAt;
  DateTime updatedAt;

  NewList({
    required this.id,
    required this.name,
    required this.minPrice,
    required this.maxPrice,
    required this.type,
    required this.serviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewList.fromJson(Map<String, dynamic> json) {
    return NewList(
      id: json['id'],
      name: json['name'],
      minPrice: json['min_price'].toDouble(),
      maxPrice: json['max_price'].toDouble(),
      type: json['type'],
      serviceId: json['service_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
