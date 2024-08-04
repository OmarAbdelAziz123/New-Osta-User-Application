class GetAllTransactionsModel {
  bool? success;
  String? message;
  List<Result>? result;

  GetAllTransactionsModel({this.success, this.message, this.result});

  GetAllTransactionsModel.fromJson(Map<String, dynamic> json) {
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
  String? amount;
  String? type;
  String? description;
  String? createdAt;

  Result({this.id, this.amount, this.type, this.description, this.createdAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    type = json['type'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
