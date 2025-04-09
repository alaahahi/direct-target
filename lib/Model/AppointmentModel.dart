
class AppointmentModel {
  String? status;
  String? message;
  List<Appointment>? appointment;

  AppointmentModel({this.status, this.message, this.appointment});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['appointment'] != null) {
      appointment = <Appointment>[];
      json['appointment'].forEach((v) {
        appointment!.add(new Appointment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.appointment != null) {
      data['appointment'] = this.appointment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appointment {
  int? id;
  int? userId;
  int? cardId;
  String? start;
  String? end;
  int? isCome;
  String? createdAt;
  String? updatedAt;
  String? note;
  int? serviceProviderId;
  String? source;
  User? user;
  ServiceProvider? serviceProvider;

  Appointment(
      {this.id,
        this.userId,
        this.cardId,
        this.start,
        this.end,
        this.isCome,
        this.createdAt,
        this.updatedAt,
        this.note,
        this.serviceProviderId,
        this.source,
        this.user,
        this.serviceProvider});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    start = json['start'];
    end = json['end'];
    isCome = json['is_come'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    note = json['note'];
    serviceProviderId = json['service_provider_id'];
    source = json['source'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    serviceProvider = json['service_provider'] != null
        ? new ServiceProvider.fromJson(json['service_provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['card_id'] = this.cardId;
    data['start'] = this.start;
    data['end'] = this.end;
    data['is_come'] = this.isCome;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['note'] = this.note;
    data['service_provider_id'] = this.serviceProviderId;
    data['source'] = this.source;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.serviceProvider != null) {
      data['service_provider'] = this.serviceProvider!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? typeId;
  String? phoneNumber;
  String? verificationDate;
  String? verificationUserType;
  String? familyMembersNames;
  String? birthDate;
  int? weight;
  int? height;
  int? gender;
  String? token;
  String? network;
  String? device;
  String? fcmToken;

  User(
      {this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.typeId,
        this.phoneNumber,
        this.verificationDate,
        this.verificationUserType,
        this.familyMembersNames,
        this.birthDate,
        this.weight,
        this.height,
        this.gender,
        this.token,
        this.network,
        this.device,
        this.fcmToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
    phoneNumber = json['phone_number'];
    verificationDate = json['verification_date'];
    verificationUserType = json['verification_user_type'];
    familyMembersNames = json['family_members_names'];
    birthDate = json['birth_date'];
    weight = json['weight'];
    height = json['height'];
    gender = json['gender'];
    token = json['token'];
    network = json['network'];
    device = json['device'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type_id'] = this.typeId;
    data['phone_number'] = this.phoneNumber;
    data['verification_date'] = this.verificationDate;
    data['verification_user_type'] = this.verificationUserType;
    data['family_members_names'] = this.familyMembersNames;
    data['birth_date'] = this.birthDate;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['gender'] = this.gender;
    data['token'] = this.token;
    data['network'] = this.network;
    data['device'] = this.device;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}

class ServiceProvider {
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
  bool? isPopular;
  int? categoryId;
  String? reviewRate;
  int? exYear;
  String? serviceName;
  String? description;
  String? specialty;

  ServiceProvider(
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
        this.specialty});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
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


