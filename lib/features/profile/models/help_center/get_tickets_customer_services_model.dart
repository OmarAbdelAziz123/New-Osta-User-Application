import 'package:osta_user_app/features/offer/models/inbox/get_all_messages_model.dart';

class GetTicketsModel {
  bool? success;
  String? message;
  List<TicketsList>? result;

  GetTicketsModel({this.success, this.message, this.result});

  GetTicketsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = <TicketsList>[];
      json['result'].forEach((v) {
        result!.add(new TicketsList.fromJson(v));
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

class TicketsList {
  int? id;
  String? title;
  String? description;
  List<Media>? media;
  String? status;
  Conversation? conversation;

  TicketsList(
      {this.id, this.title, this.description, this.status, this.conversation});

  TicketsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    conversation = json['conversation'] != null
        ? new Conversation.fromJson(json['conversation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.conversation != null) {
      data['conversation'] = this.conversation!.toJson();
    }
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
