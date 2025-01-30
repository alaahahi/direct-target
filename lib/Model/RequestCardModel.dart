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
  List<String>? familyMembersNames; // تعديل من String إلى List<String>
  String? image;
  String? source;
  String? updatedAt;
  String? createdAt;
  int? id;

  RequestCardData({
    this.name,
    this.phone,
    this.address,
    this.cardNumber,
    this.familyMembersNames,
    this.image,
    this.source,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  RequestCardData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    cardNumber = json['card_number'];

    // تحقق من نوع family_members_names
    if (json['family_members_names'] is List) {
      familyMembersNames = List<String>.from(json['family_members_names']);
    } else if (json['family_members_names'] is String) {
      familyMembersNames = [json['family_members_names']]; // تحويل الـ String إلى قائمة تحتوي على اسم واحد
    } else {
      familyMembersNames = null; // إذا كانت القيمة غير متوقعة
    }

    image = json['image'];
    source = json['source'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['card_number'] = cardNumber;
    data['family_members_names'] = familyMembersNames ?? []; // تأكد أنها قائمة فارغة إذا لم يتم إدخالها
    data['image'] = image;
    data['source'] = source;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}


