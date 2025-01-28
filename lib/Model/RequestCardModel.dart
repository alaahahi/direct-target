class RequestCardModel {
  String? message;
  RequestCardData? data;

  RequestCardModel({this.message, this.data});

  RequestCardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new RequestCardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RequestCardData {
  String? name;
  String? phone;
  String? address;
  String? cardNumber;
  String? familyMembersNames;
  String? image;
  String? source;
  String? updatedAt;
  String? createdAt;
  int? id;

  RequestCardData(
      {this.name,
        this.phone,
        this.address,
        this.cardNumber,
        this.familyMembersNames,
        this.image,
        this.source,
        this.updatedAt,
        this.createdAt,
        this.id});

  RequestCardData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    cardNumber = json['card_number'];
    familyMembersNames = json['family_members_names'];
    image = json['image'];
    source = json['source'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['card_number'] = this.cardNumber;
    data['family_members_names'] = this.familyMembersNames;
    data['image'] = this.image;
    data['source'] = this.source;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
