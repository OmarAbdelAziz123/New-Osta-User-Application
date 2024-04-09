class CheckPhoneModel {
  bool? success;
  String? message;
  Null? result;

  CheckPhoneModel({this.success, this.message, this.result});

  CheckPhoneModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['result'] = this.result;
    return data;
  }
}
