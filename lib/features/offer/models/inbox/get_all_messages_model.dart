// class GetAllMessagesModel {
//   bool? success;
//   String? message;
//   Result? result;
//
//   GetAllMessagesModel({this.success, this.message, this.result});
//
//   GetAllMessagesModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     result =
//     json['result'] != null ? new Result.fromJson(json['result']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.result != null) {
//       data['result'] = this.result!.toJson();
//     }
//     return data;
//   }
// }
//
// class Result {
//   List<Messages>? messages;
//   Conversation? conversation;
//   String? participant;
//
//   Result({this.messages, this.conversation, this.participant});
//
//   Result.fromJson(Map<String, dynamic> json) {
//     if (json['messages'] != null) {
//       messages = <Messages>[];
//       json['messages'].forEach((v) {
//         messages!.add(new Messages.fromJson(v));
//       });
//     }
//     conversation = json['conversation'] != null
//         ? new Conversation.fromJson(json['conversation'])
//         : null;
//     participant = json['participant'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.messages != null) {
//       data['messages'] = this.messages!.map((v) => v.toJson()).toList();
//     }
//     if (this.conversation != null) {
//       data['conversation'] = this.conversation!.toJson();
//     }
//     data['participant'] = this.participant;
//     return data;
//   }
// }
//
// class Messages {
//   dynamic? id;
//   String? content;
//   bool? isMe;
//   bool? isRead;
//   String? createdAt;
//   List<Media>? media;
//   OptionsModel? options;
//
//   Messages(
//       {this.id,
//         this.content,
//         this.isMe,
//         this.isRead,
//         this.createdAt,
//         this.media,
//         this.options});
//
//   Messages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     content = json['content'];
//     isMe = json['is_me'];
//     isRead = json['is_read'];
//     createdAt = json['created_at'];
//     if (json['media'] != null) {
//       media = <Media>[];
//       json['media'].forEach((v) {
//         media!.add(new Media.fromJson(v));
//       });
//     }
//     options =
//     json['options'] != null ? new OptionsModel.fromJson(json['options']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['content'] = this.content;
//     data['is_me'] = this.isMe;
//     data['is_read'] = this.isRead;
//     data['created_at'] = this.createdAt;
//     if (this.media != null) {
//       data['media'] = this.media!.map((v) => v.toJson()).toList();
//     }
//     if (this.options != null) {
//       data['options'] = this.options!.toJson();
//     }
//     return data;
//   }
// }
//
// class Media {
//   dynamic? id;
//   String? url;
//   String? thumb;
//
//   Media({this.id, this.url, this.thumb});
//
//   Media.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     thumb = json['thumb'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['url'] = this.url;
//     data['thumb'] = this.thumb;
//     return data;
//   }
// }
//
// class OptionsModel {
//   Variables? variables;
//   List<OptionsData>? options;
//   String? url;
//   String? actionName;
//   String? actionStatus;
//
//   OptionsModel(
//       {this.variables,
//         this.options,
//         this.url,
//         this.actionName,
//         this.actionStatus});
//
//   OptionsModel.fromJson(Map<String, dynamic> json) {
//     variables = json['variables'] != null
//         ? new Variables.fromJson(json['variables'])
//         : null;
//     if (json['options'] != null) {
//       options = <OptionsData>[];
//       json['options'].forEach((v) {
//         options!.add(new OptionsData.fromJson(v));
//       });
//     }
//     url = json['url'];
//     actionName = json['action_name'];
//     actionStatus = json['action_status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.variables != null) {
//       data['variables'] = this.variables!.toJson();
//     }
//     if (this.options != null) {
//       data['options'] = this.options!.map((v) => v.toJson()).toList();
//     }
//     data['url'] = this.url;
//     data['action_name'] = this.actionName;
//     data['action_status'] = this.actionStatus;
//     return data;
//   }
// }
//
// class Variables {
//   String? x;
//
//   Variables({this.x});
//
//   Variables.fromJson(Map<String, dynamic> json) {
//     x = json['x'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['x'] = this.x;
//     return data;
//   }
// }
//
// class OptionsData {
//   String? name;
//   String? valueResponse;
//
//   OptionsData({this.name, this.valueResponse});
//
//   OptionsData.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     valueResponse = json['value_response'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['value_response'] = this.valueResponse;
//     return data;
//   }
// }
//
// class Conversation {
//   dynamic? id;
//   String? name;
//   String? type;
//   dynamic? isActive;
//   String? modelType;
//   dynamic? modelId;
//   String? createdAt;
//   String? updatedAt;
//
//   Conversation(
//       {this.id,
//         this.name,
//         this.type,
//         this.isActive,
//         this.modelType,
//         this.modelId,
//         this.createdAt,
//         this.updatedAt});
//
//   Conversation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     type = json['type'];
//     isActive = json['is_active'];
//     modelType = json['model_type'];
//     modelId = json['model_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
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
//     return data;
//   }
// }

/// ************************************************************ ///
class GetAllMessagesModel {
  bool? success;
  String? message;
  Result? result;

  GetAllMessagesModel({this.success, this.message, this.result});

  GetAllMessagesModel.fromJson(Map<String, dynamic> json) {
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
  List<Messages>? messages;
  Conversation? conversation;
  String? participant;

  Result({this.messages, this.conversation, this.participant});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    conversation = json['conversation'] != null
        ? new Conversation.fromJson(json['conversation'])
        : null;
    participant = json['participant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    if (this.conversation != null) {
      data['conversation'] = this.conversation!.toJson();
    }
    data['participant'] = this.participant;
    return data;
  }
}

class Messages {
  int? id;
  String? content;
  bool? isMe;
  bool? isRead;
  String? createdAt;
  List<Media>? media;
  OptionsModel? options;

  Messages(
      {this.id,
        this.content,
        this.isMe,
        this.isRead,
        this.createdAt,
        this.media,
        this.options});

  Messages.fromJson(Map<String, dynamic> json) {
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
    json['options'] != null ? new OptionsModel.fromJson(json['options']) : null;
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

class OptionsModel {
  Variables? variables;
  List<OptionsData>? options;
  String? url;
  String? actionName;
  String? actionStatus;

  OptionsModel(
      {this.variables,
        this.options,
        this.url,
        this.actionName,
        this.actionStatus});

  OptionsModel.fromJson(Map<String, dynamic> json) {
    // variables = json['variables'] != null
    //     ? new Variables.fromJson(json['variables'])
    //     : null;
    if (json['options'] != null) {
      options = <OptionsData>[];
      json['options'].forEach((v) {
        options!.add(new OptionsData.fromJson(v));
      });
    }
    url = json['url'];
    actionName = json['action_name'];
    actionStatus = json['action_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.variables != null) {
      data['variables'] = this.variables!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['url'] = this.url;
    data['action_name'] = this.actionName;
    data['action_status'] = this.actionStatus;
    return data;
  }
}

class Variables {
  String? x;

  Variables({this.x});

  Variables.fromJson(Map<String, dynamic> json) {
    x = json['x'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    return data;
  }
}

class OptionsData {
  String? name;
  String? valueResponse;

  OptionsData({this.name, this.valueResponse});

  OptionsData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    valueResponse = json['value_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value_response'] = this.valueResponse;
    return data;
  }
}

class Conversation {
  int? id;
  String? name;
  String? type;
  int? isActive;
  String? modelType;
  int? modelId;
  String? createdAt;
  String? updatedAt;

  Conversation(
      {this.id,
        this.name,
        this.type,
        this.isActive,
        this.modelType,
        this.modelId,
        this.createdAt,
        this.updatedAt});

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isActive = json['is_active'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}


// class GetAllMessagesModel {
//   bool? success;
//   String? message;
//   Result? result;
//
//   GetAllMessagesModel({this.success, this.message, this.result});
//
//   GetAllMessagesModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     result =
//     json['result'] != null ? new Result.fromJson(json['result']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.result != null) {
//       data['result'] = this.result!.toJson();
//     }
//     return data;
//   }
// }
//
// class Result {
//   List<MessageResult>? messages;
//   Conversation? conversation;
//   String? participant;
//
//   Result({this.messages, this.conversation, this.participant});
//
//   Result.fromJson(Map<String, dynamic> json) {
//     if (json['messages'] != null) {
//       messages = <MessageResult>[];
//       json['messages'].forEach((v) {
//         messages!.add(new MessageResult.fromJson(v));
//       });
//     }
//     conversation = json['conversation'] != null
//         ? new Conversation.fromJson(json['conversation'])
//         : null;
//     participant = json['participant'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.messages != null) {
//       data['messages'] = this.messages!.map((v) => v.toJson()).toList();
//     }
//     if (this.conversation != null) {
//       data['conversation'] = this.conversation!.toJson();
//     }
//     data['participant'] = this.participant;
//     return data;
//   }
// }
//
// class MessageResult {
//   dynamic? id;
//   String? content;
//   bool? isMe;
//   bool? isRead;
//   String? createdAt;
//   List<Media>? media;
//   OptionsDataDataModel? options;
//
//   MessageResult(
//       {this.id,
//         this.content,
//         this.isMe,
//         this.isRead,
//         this.createdAt,
//         this.media,
//         this.options});
//
//   MessageResult.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     content = json['content'];
//     isMe = json['is_me'];
//     isRead = json['is_read'];
//     createdAt = json['created_at'];
//     if (json['media'] != null) {
//       media = <Media>[];
//       json['media'].forEach((v) {
//         media!.add(new Media.fromJson(v));
//       });
//     }
//     options =
//     json['options'] != null ? new OptionsModel.fromJson(json['options']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['content'] = this.content;
//     data['is_me'] = this.isMe;
//     data['is_read'] = this.isRead;
//     data['created_at'] = this.createdAt;
//     if (this.media != null) {
//       data['media'] = this.media!.map((v) => v.toJson()).toList();
//     }
//     if (this.options != null) {
//       data['options'] = this.options!.toJson();
//     }
//     return data;
//   }
// }
//
// class Media {
//   dynamic? id;
//   String? url;
//   String? thumb;
//
//   Media({this.id, this.url, this.thumb});
//
//   Media.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     thumb = json['thumb'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['url'] = this.url;
//     data['thumb'] = this.thumb;
//     return data;
//   }
// }
//
// class OptionsModel {
//   Variables? variables;
//   List<OptionsData>? options;
//   String? url;
//   String? actionName;
//   String? actionStatus;
//
//   OptionsModel(
//       {this.variables,
//         this.options,
//         this.url,
//         this.actionName,
//         this.actionStatus});
//
//   OptionsModel.fromJson(Map<String, dynamic> json) {
//     variables = json['variables'] != null
//         ? new Variables.fromJson(json['variables'])
//         : null;
//     if (json['options'] != null) {
//       options = <OptionsData>[];
//       json['options'].forEach((v) {
//         options!.add(new OptionsData.fromJson(v));
//       });
//     }
//     url = json['url'];
//     actionName = json['action_name'];
//     actionStatus = json['action_status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.variables != null) {
//       data['variables'] = this.variables!.toJson();
//     }
//     if (this.options != null) {
//       data['options'] = this.options!.map((v) => v.toJson()).toList();
//     }
//     data['url'] = this.url;
//     data['action_name'] = this.actionName;
//     data['action_status'] = this.actionStatus;
//     return data;
//   }
// }
//
// class Variables {
//   String? x;
//
//   Variables({this.x});
//
//   Variables.fromJson(Map<String, dynamic> json) {
//     x = json['x'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['x'] = this.x;
//     return data;
//   }
// }
//
// class OptionsData {
//   String? name;
//   String? valueResponse;
//
//   OptionsData({this.name, this.valueResponse});
//
//   OptionsData.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     valueResponse = json['value_response'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['value_response'] = this.valueResponse;
//     return data;
//   }
// }
//
// class Conversation {
//   dynamic? id;
//   String? name;
//   String? type;
//   dynamic? isActive;
//   String? modelType;
//   dynamic? modelId;
//   String? createdAt;
//   String? updatedAt;
//
//   Conversation(
//       {this.id,
//         this.name,
//         this.type,
//         this.isActive,
//         this.modelType,
//         this.modelId,
//         this.createdAt,
//         this.updatedAt});
//
//   Conversation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     type = json['type'];
//     isActive = json['is_active'];
//     modelType = json['model_type'];
//     modelId = json['model_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
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
//     return data;
//   }
// }
