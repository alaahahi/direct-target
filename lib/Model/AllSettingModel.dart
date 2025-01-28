class AllSettingModel {
  String? status;
  AllSetting? data;

  AllSettingModel({this.status, this.data});
  AllSettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? AllSetting.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AllSetting {
  int? id;
  String? key;
  String? value;
  String? type;
  String? description;
  String? createdAt;
  String? updatedAt;

  AllSetting({
    this.id,
    this.key,
    this.value,
    this.type,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  AllSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    type = json['type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['type'] = this.type;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
