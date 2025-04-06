class CardServiceModel {
  String? status;
  List<CardService>? CardServiceData;

  CardServiceModel({this.status, this.CardServiceData});

  CardServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      CardServiceData = <CardService>[];
      json['data'].forEach((v) {
        CardServiceData!.add(new CardService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.CardServiceData != null) {
      data['data'] = this.CardServiceData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardService {
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
  String? serviceName;
  String? description;
  String? specialty;

  CardService(
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
        this.serviceName,
        this.description,
        this.specialty});

  CardService.fromJson(Map<String, dynamic> json) {
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
    serviceName = json['service_name'];
    description = json['description'];
    specialty = json['specialty'];
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
    data['service_name'] = this.serviceName;
    data['description'] = this.description;
    data['specialty'] = this.specialty;
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
