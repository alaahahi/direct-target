class ProfileModel {
  String? status;
  List<ProfileData>? data;

  ProfileModel({this.status, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProfileData>[];
      json['data'].forEach((v) {
        data!.add(new ProfileData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  String? name;
  String? address;
  int? cardNumber;
  String? familyName;
  String? phoneNumber;
  String? invoiceNumber;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? userAdd;
  int? results;
  int? no;
  int? cardId;
  String? created;
  String? userAccepted;
  String? image;
  String? source;
  int? cardHolderId;

  ProfileData(
      {this.id,
        this.name,
        this.address,
        this.cardNumber,
        this.familyName,
        this.phoneNumber,
        this.invoiceNumber,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.userAdd,
        this.results,
        this.no,
        this.cardId,
        this.created,
        this.userAccepted,
        this.image,
        this.source,
        this.cardHolderId});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    cardNumber = json['card_number'];
    familyName = json['family_name'];
    phoneNumber = json['phone_number'];
    invoiceNumber = json['invoice_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    userAdd = json['user_add'];
    results = json['results'];
    no = json['no'];
    cardId = json['card_id'];
    created = json['created'];
    userAccepted = json['user_accepted'];
    image = json['image'];
    source = json['source'];
    cardHolderId = json['cardHolder_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['card_number'] = this.cardNumber;
    data['family_name'] = this.familyName;
    data['phone_number'] = this.phoneNumber;
    data['invoice_number'] = this.invoiceNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['user_add'] = this.userAdd;
    data['results'] = this.results;
    data['no'] = this.no;
    data['card_id'] = this.cardId;
    data['created'] = this.created;
    data['user_accepted'] = this.userAccepted;
    data['image'] = this.image;
    data['source'] = this.source;
    data['cardHolder_id'] = this.cardHolderId;
    return data;
  }
}
