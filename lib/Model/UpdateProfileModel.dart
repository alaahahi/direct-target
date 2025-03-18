

class UpdateProfileModel {
  String? status;
  String? message;
  Data? data;

  UpdateProfileModel({this.status, this.message, this.data});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? address;
  String? familyMembersNames;
  String? birthDate;
  String? weight;
  String? height;
  String? gender;
  String? token;
  String? network;
  String? device;

  Data(
      {this.name,
        this.address,
        this.familyMembersNames,
        this.birthDate,
        this.weight,
        this.height,
        this.gender,
        this.token,
        this.network,
        this.device});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    familyMembersNames = json['family_members_names'];
    birthDate = json['birth_date'];
    weight = json['weight'];
    height = json['height'];
    gender = json['gender'];
    token = json['token'];
    network = json['network'];
    device = json['device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['family_members_names'] = this.familyMembersNames;
    data['birth_date'] = this.birthDate;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['gender'] = this.gender;
    data['token'] = this.token;
    data['network'] = this.network;
    data['device'] = this.device;
    return data;
  }
}

