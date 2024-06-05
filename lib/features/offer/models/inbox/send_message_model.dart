class SendMessageModel {
  bool? success;
  String? message;
  Result? result;

  SendMessageModel({this.success, this.message, this.result});

  SendMessageModel.fromJson(Map<String, dynamic> json) {
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
  String? content;
  bool? isMe;
  bool? isRead;
  String? createdAt;

  Result(
      {this.id,
        this.content,
        this.isMe,
        this.isRead,
        this.createdAt,
});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isMe = json['is_me'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['is_me'] = this.isMe;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    return data;
  }
}
