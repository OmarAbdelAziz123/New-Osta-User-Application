class AllServicesModel {
  bool? success;
  String? message;
  List<Result>? result;

  AllServicesModel({this.success, this.message, this.result});

  AllServicesModel.fromJson(Map<String, dynamic> json) {
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
  String? category;

  Result({this.id, this.name, this.minPrice, this.maxPrice, this.category});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['category'] = this.category;
    return data;
  }
}
