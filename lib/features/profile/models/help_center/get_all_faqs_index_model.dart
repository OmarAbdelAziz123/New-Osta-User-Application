class GetAllFaqsIndexModel {
  bool? success;
  String? message;
  List<AllDataIndex>? allDataIndex;

  GetAllFaqsIndexModel({this.success, this.message, this.allDataIndex});

  GetAllFaqsIndexModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      allDataIndex = <AllDataIndex>[];
      json['result'].forEach((v) {
        allDataIndex!.add(new AllDataIndex.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.allDataIndex != null) {
      data['result'] = this.allDataIndex!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllDataIndex {
  int? id;
  String? question;
  String? answer;
  Category? category;

  AllDataIndex({this.id, this.question, this.answer, this.category});

  AllDataIndex.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
