import 'package:osta_user_app/features/profile/models/help_center/get_tickets_customer_services_model.dart';

class SendTicketResponseModel {
  bool? success;
  String? message;
  TicketsList? result;

  SendTicketResponseModel({this.success, this.message, this.result});

  SendTicketResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
    json['result'] != null ? new TicketsList.fromJson(json['result']) : null;
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
