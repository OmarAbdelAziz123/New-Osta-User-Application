import 'package:osta/features/offer/models/inbox/get_all_messages_model.dart';

class SendMessageResponseModel {
  String? event;
  String? message;
  Messages? data;

  SendMessageResponseModel({this.event, this.message, this.data});

  SendMessageResponseModel.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    message = json['message'];
    data = json['result'] != null ? new Messages.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['message'] = this.message;
    if (this.data != null) {
      data['result'] = this.data!.toJson();
    }
    return data;
  }
}

