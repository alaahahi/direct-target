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
  String? serviceName;
  String? description;
  int? price;
  String? createdAt;
  String? updatedAt;
  List<String>? workingDays;
  WorkingHours? workingHours;
  int? appointmentsPerDay;
  String? expirDate;
  bool? showOnApp;
  String? image;

  CardService({
    this.id,
    this.cardId,
    this.serviceName,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.workingDays,
    this.workingHours,
    this.appointmentsPerDay,
    this.expirDate,
    this.showOnApp,
    this.image,
  });

  CardService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardId = json['card_id'];
    serviceName = json['service_name'];
    description = json['description'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    // التأكد من أن working_days ليست null وتكون قائمة من String
    workingDays = json['working_days'] != null
        ? List<String>.from(json['working_days'])
        : [];

    // التأكد من أن working_hours ليست null وتكون كائن صالح
    workingHours = json['working_hours'] != null
        ? WorkingHours.fromJson(json['working_hours'])
        : null;

    appointmentsPerDay = json['appointments_per_day'];
    expirDate = json['expir_date'];
    showOnApp = json['show_on_app'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_id'] = this.cardId;
    data['service_name'] = this.serviceName;
    data['description'] = this.description;
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