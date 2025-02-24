class PopularServiceModel {
  String? status;
  List<PopularServiceData>? data;

  PopularServiceModel({this.status, this.data});

  PopularServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PopularServiceData>[];
      json['data'].forEach((v) {
        data!.add(new PopularServiceData.fromJson(v));
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

class PopularServiceData {
  int? id;
  int? cardId;
  String? serviceNameAr;
  String? descriptionAr;
  String? price;
  String? createdAt;
  String? updatedAt;
  List<String>? workingDays;
  WorkingHours? workingHours;
  int? appointmentsPerDay;
  String? expirDate;
  bool? showOnApp;
  String? image;
  String? specialtyAr;
  int? discountRate;
  String? serviceNameEn;
  String? descriptionEn;
  String? specialtyEn;
  String? currency;
  int? isPopular;
  int? categoryId;
  String? reviewRate;
  int? exYear;
  String? serviceName;
  String? description;
  String? specialty;
  Card? card;
  Category? category;

  PopularServiceData(
      {this.id,
        this.cardId,
        this.serviceNameAr,
        this.descriptionAr,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.workingDays,
        this.workingHours,
        this.appointmentsPerDay,
        this.expirDate,
        this.showOnApp,
        this.image,
        this.specialtyAr,
        this.discountRate,
        this.serviceNameEn,
        this.descriptionEn,
        this.specialtyEn,
        this.currency,
        this.isPopular,
        this.categoryId,
        this.reviewRate,
        this.exYear,
        this.serviceName,
        this.description,
        this.specialty,
        this.card,
        this.category});

  PopularServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardId = json['card_id'];
    serviceNameAr = json['service_name_ar'];
    descriptionAr = json['description_ar'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    workingDays = json['working_days'].cast<String>();
    workingHours = json['working_hours'] != null
        ? new WorkingHours.fromJson(json['working_hours'])
        : null;
    appointmentsPerDay = json['appointments_per_day'];
    expirDate = json['expir_date'];
    showOnApp = json['show_on_app'];
    image = json['image'];
    specialtyAr = json['specialty_ar'];
    discountRate = json['discount_rate'];
    serviceNameEn = json['service_name_en'];
    descriptionEn = json['description_en'];
    specialtyEn = json['specialty_en'];
    currency = json['currency'];
    isPopular = json['is_popular'];
    categoryId = json['category_id'];
    reviewRate = json['review_rate'];
    exYear = json['ex_year'];
    serviceName = json['service_name'];
    description = json['description'];
    specialty = json['specialty'];
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_id'] = this.cardId;
    data['service_name_ar'] = this.serviceNameAr;
    data['description_ar'] = this.descriptionAr;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['working_days'] = this.workingDays;
    if (this.workingHours != null) {
      data['working_hours'] = this.workingHours!.toJson();
    }
    data['appointments_per_day'] = this.appointmentsPerDay;
    data['expir_date'] = this.expirDate;
    data['show_on_app'] = this.showOnApp;
    data['image'] = this.image;
    data['specialty_ar'] = this.specialtyAr;
    data['discount_rate'] = this.discountRate;
    data['service_name_en'] = this.serviceNameEn;
    data['description_en'] = this.descriptionEn;
    data['specialty_en'] = this.specialtyEn;
    data['currency'] = this.currency;
    data['is_popular'] = this.isPopular;
    data['category_id'] = this.categoryId;
    data['review_rate'] = this.reviewRate;
    data['ex_year'] = this.exYear;
    data['service_name'] = this.serviceName;
    data['description'] = this.description;
    data['specialty'] = this.specialty;
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class WorkingHours {
  String? start;
  String? end;

  WorkingHours({this.start, this.end});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}

class Card {
  int? id;
  String? nameAr;
  String? nameEn;
  int? day;
  int? price;
  bool? showOnApp;
  String? expirDate;
  String? createdAt;
  Null? updatedAt;
  String? image;
  String? currency;
  String? name;

  Card(
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
        this.name});

  Card.fromJson(Map<String, dynamic> json) {
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
    name = json['name'];
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
    data['name'] = this.name;
    return data;
  }
}

class Category {
  int? id;
  String? nameEn;
  String? nameAr;
  Null? icon;
  int? discount;
  String? createdAt;
  Null? updatedAt;

  Category(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.icon,
        this.discount,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    icon = json['icon'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['icon'] = this.icon;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
