class GetAllMessagesModel {
  bool? success;
  String? message;
  List<MessageResult>? result;

  GetAllMessagesModel({this.success, this.message, this.result});

  GetAllMessagesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = <MessageResult>[];
      json['result'].forEach((v) {
        result!.add(new MessageResult.fromJson(v));
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

class MessageResult {
  int? id;
  String? content;
  bool? isMe;
  bool? isRead;
  String? createdAt;
  List<Media>? media;

  MessageResult(
      {this.id,
        this.content,
        this.isMe,
        this.isRead,
        this.createdAt,
        this.media});

  MessageResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isMe = json['is_me'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['is_me'] = this.isMe;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int? id;
  String? url;
  String? thumb;

  Media({this.id, this.url, this.thumb});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['thumb'] = this.thumb;
    return data;
  }
}
