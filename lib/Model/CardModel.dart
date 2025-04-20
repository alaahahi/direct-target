

class CardModel {
  String? status;
  List<CardData>? CardsData;

  CardModel({this.status, this.CardsData});

  CardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      CardsData = <CardData>[];
      json['data'].forEach((v) {
        CardsData!.add(new CardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.CardsData != null) {
      data['data'] = this.CardsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardData {
  int? id;
  String? nameAr;
  String? nameEn;
  int? day;
  int? price;
  bool? showOnApp;
  String? expirDate;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? currency;
  String? descriptionAr;
  String? descriptionEn;
  String? name;
  String? description;

  CardData(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.day,
        this.price,
        this.showOnApp,
        this.expirDate,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.currency,
        this.descriptionAr,
        this.descriptionEn,
        this.name,
        this.description});

  CardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    day = json['day'];
    price = json['price'];
    showOnApp = json['show_on_app'];
    expirDate = json['expir_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    currency = json['currency'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['day'] = this.day;
    data['price'] = this.price;
    data['show_on_app'] = this.showOnApp;
    data['expir_date'] = this.expirDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['currency'] = this.currency;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}


