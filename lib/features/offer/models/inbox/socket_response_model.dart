import 'package:osta_user_app/features/offer/models/inbox/get_all_messages_model.dart';

class SocketResponseModel {
  String? event;
  String? message;
  Messages? data;

  SocketResponseModel({this.event, this.message, this.data});

  SocketResponseModel.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    message = json['message'];
    data = json['data'] != null ? new Messages.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

