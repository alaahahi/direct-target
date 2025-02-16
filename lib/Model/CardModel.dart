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
  String? name;
  String? nameEn;
  int? day;
  int? price;
  bool? showOnApp;
  String? expirDate;
  String? createdAt;
  String? updatedAt;

  CardData(
      {this.id,
        this.name,
        this.nameEn,
        this.day,
        this.price,
        this.showOnApp,
        this.expirDate,
        this.createdAt,
        this.updatedAt});

  CardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    day = json['day'];
    price = json['price'];
    showOnApp = json['show_on_app'];
    expirDate = json['expir_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['day'] = this.day;
    data['price'] = this.price;
    data['show_on_app'] = this.showOnApp;
    data['expir_date'] = this.expirDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
