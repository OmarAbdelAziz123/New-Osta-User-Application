class GetAllAddressesModel {
  bool? success;
  String? message;
  List<AddressList>? result;

  GetAllAddressesModel({this.success, this.message, this.result});

  GetAllAddressesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = <AddressList>[];
      json['result'].forEach((v) {
        result!.add(new AddressList.fromJson(v));
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

class AddressList {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? desc;

  AddressList({this.id, this.name, this.latitude, this.longitude, this.desc});

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['desc'] = this.desc;
    return data;
  }
}
