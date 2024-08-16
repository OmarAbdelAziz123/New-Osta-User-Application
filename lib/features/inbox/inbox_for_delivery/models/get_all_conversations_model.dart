// class GetAllConversationsModel {
//   List<ConversationsData>? data;
//
//   GetAllConversationsModel({this.data});
//
//   GetAllConversationsModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <ConversationsData>[];
//       json['data'].forEach((v) {
//         data!.add(new ConversationsData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ConversationsData {
//   int? id;
//   String? name;
//   String? type;
//   int? isActive;
//   String? modelType;
//   int? modelId;
//   String? createdAt;
//   String? updatedAt;
//   List<UserShortInfo>? userShortInfo;
//
//   ConversationsData(
//       {this.id,
//         this.name,
//         this.type,
//         this.isActive,
//         this.modelType,
//         this.modelId,
//         this.createdAt,
//         this.updatedAt,
//         this.userShortInfo});
//
//   ConversationsData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     type = json['type'];
//     isActive = json['is_active'];
//     modelType = json['model_type'];
//     modelId = json['model_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['user_short_info'] != null) {
//       userShortInfo = <UserShortInfo>[];
//       json['user_short_info'].forEach((v) {
//         userShortInfo!.add(new UserShortInfo.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     data['is_active'] = this.isActive;
//     data['model_type'] = this.modelType;
//     data['model_id'] = this.modelId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.userShortInfo != null) {
//       data['user_short_info'] =
//           this.userShortInfo!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class UserShortInfo {
//   int? id;
//   String? name;
//   String? phone;
//   String? personalMediaUrl;
//
//   UserShortInfo({this.id, this.name, this.phone, this.personalMediaUrl});
//
//   UserShortInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     phone = json['phone'];
//     personalMediaUrl = json['personal_media_url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['personal_media_url'] = this.personalMediaUrl;
//     return data;
//   }
// }


class GetAllConversationsModel {
  List<ConversationsData>? data;

  GetAllConversationsModel({this.data});

  GetAllConversationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ConversationsData>[];
      json['data'].forEach((v) {
        data!.add(new ConversationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationsData {
  int? id;
  String? name;
  String? type;
  int? isActive;
  String? modelType;
  int? modelId;
  String? createdAt;
  String? updatedAt;
  LastMessage? lastMessage;
  List<UserShortInfo>? userShortInfo;

  ConversationsData(
      {this.id,
        this.name,
        this.type,
        this.isActive,
        this.modelType,
        this.modelId,
        this.createdAt,
        this.updatedAt,
        this.lastMessage,
        this.userShortInfo});

  ConversationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isActive = json['is_active'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
    if (json['user_short_info'] != null) {
      userShortInfo = <UserShortInfo>[];
      json['user_short_info'].forEach((v) {
        userShortInfo!.add(new UserShortInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['is_active'] = this.isActive;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    if (this.userShortInfo != null) {
      data['user_short_info'] =
          this.userShortInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastMessage {
  int? id;
  String? content;
  bool? isMe;
  bool? isRead;
  String? createdAt;
  List<Media>? media;
  Options? options;

  LastMessage(
      {this.id,
        this.content,
        this.isMe,
        this.isRead,
        this.createdAt,
        this.media,
        this.options});

  LastMessage.fromJson(Map<String, dynamic> json) {
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
    options =
    json['options'] != null ? new Options.fromJson(json['options']) : null;
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
    if (this.options != null) {
      data['options'] = this.options!.toJson();
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

class Options {
  Null? variables;
  Null? options;
  Null? url;
  Null? actionName;
  String? actionStatus;

  Options(
      {this.variables,
        this.options,
        this.url,
        this.actionName,
        this.actionStatus});

  Options.fromJson(Map<String, dynamic> json) {
    variables = json['variables'];
    options = json['options'];
    url = json['url'];
    actionName = json['action_name'];
    actionStatus = json['action_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variables'] = this.variables;
    data['options'] = this.options;
    data['url'] = this.url;
    data['action_name'] = this.actionName;
    data['action_status'] = this.actionStatus;
    return data;
  }
}

class UserShortInfo {
  int? id;
  String? name;
  String? phone;
  String? personalMediaUrl;

  UserShortInfo({this.id, this.name, this.phone, this.personalMediaUrl});

  UserShortInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    personalMediaUrl = json['personal_media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['personal_media_url'] = this.personalMediaUrl;
    return data;
  }
}
