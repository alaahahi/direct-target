
class AllCardServicesModel {
  String? status;
  List<AllCardServicesData>? data;

  AllCardServicesModel({this.status, this.data});

  AllCardServicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AllCardServicesData>[];
      json['data'].forEach((v) {
        data!.add(new AllCardServicesData.fromJson(v));
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

class AllCardServicesData {
  int? categoryId;
  String? categoryName;
  String? categoryIcon;
  String? categoryColor;
  int? categoryDiscount;
  List<Subcategories>? subcategories;

  AllCardServicesData(
      {this.categoryId,
        this.categoryName,
        this.categoryIcon,
        this.categoryColor,
        this.categoryDiscount,
        this.subcategories});

  AllCardServicesData.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryIcon = json['category_icon'];
    categoryColor = json['category_color'];
    categoryDiscount = json['category_discount'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_icon'] = this.categoryIcon;
    data['category_color'] = this.categoryColor;
    data['category_discount'] = this.categoryDiscount;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int? subcategoryId;
  String? subcategoryName;
  List<Services>? services;

  Subcategories({this.subcategoryId, this.subcategoryName, this.services});

  Subcategories.fromJson(Map<String, dynamic> json) {
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategory_id'] = this.subcategoryId;
    data['subcategory_name'] = this.subcategoryName;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  int? cardId;
  String? serviceName;
  String? description;
  String? specialty;
  String? price;
  List<String>? workingDays;
  WorkingHours? workingHours;
  int? appointmentsPerDay;
  String? expirDate;
  bool? showOnApp;
  String? reviewRate;
  int? exYear;
  int? appointmentsCount;

  Services(
      {this.id,
        this.cardId,
        this.serviceName,
        this.description,
        this.specialty,
        this.price,
        this.workingDays,
        this.workingHours,
        this.appointmentsPerDay,
        this.expirDate,
        this.showOnApp,
        this.reviewRate,
        this.exYear,
        this.appointmentsCount});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardId = json['card_id'];
    serviceName = json['service_name'];
    description = json['description'];
    specialty = json['specialty'];
    price = json['price'];
    workingDays = json['working_days'].cast<String>();
    workingHours = json['working_hours'] != null
        ? new WorkingHours.fromJson(json['working_hours'])
        : null;
    appointmentsPerDay = json['appointments_per_day'];
    expirDate = json['expir_date'];
    showOnApp = json['show_on_app'];
    reviewRate = json['review_rate'];
    exYear = json['ex_year'];
    appointmentsCount = json['appointments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_id'] = this.cardId;
    data['service_name'] = this.serviceName;
    data['description'] = this.description;
    data['specialty'] = this.specialty;
    data['price'] = this.price;
    data['working_days'] = this.workingDays;
    if (this.workingHours != null) {
      data['working_hours'] = this.workingHours!.toJson();
    }
    data['appointments_per_day'] = this.appointmentsPerDay;
    data['expir_date'] = this.expirDate;
    data['show_on_app'] = this.showOnApp;
    data['review_rate'] = this.reviewRate;
    data['ex_year'] = this.exYear;
    data['appointments_count'] = this.appointmentsCount;
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

