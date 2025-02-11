// class AppointmentModel {
//   String? status;
//   String? message;
//   Appointment? appointment;
//
//   AppointmentModel({this.status, this.message, this.appointment});
//
//   AppointmentModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     appointment = json['appointment'] != null
//         ? new Appointment.fromJson(json['appointment'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.appointment != null) {
//       data['appointment'] = this.appointment!.toJson();
//     }
//     return data;
//   }
// }
//
// class Appointment {
//   int? userId;
//   int? cardId;
//   String? note;
//   String? start;
//   String? end;
//   String? updatedAt;
//   String? createdAt;
//   int? id;
//
//   Appointment(
//       {this.userId,
//         this.cardId,
//         this.note,
//         this.start,
//         this.end,
//         this.updatedAt,
//         this.createdAt,
//         this.id});
//
//   Appointment.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     cardId = json['card_id'];
//     note = json['note'];
//     start = json['start'];
//     end = json['end'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['card_id'] = this.cardId;
//     data['note'] = this.note;
//     data['start'] = this.start;
//     data['end'] = this.end;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     return data;
//   }
// }



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
  String? typeId;  // Changed from Null? to String?
  String? phoneNumber;
  String? verificationDate;
  String? verificationUserType;
  String? familyMembersNames;  // Changed from Null? to String?
  String? birthDate;  // Changed from Null? to String?
  String? weight;  // Changed from Null? to String?
  String? height;  // Changed from Null? to String?
  String? gender;  // Changed from Null? to String?

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
        this.gender});

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
    return data;
  }
}


class ServiceProvider {
  int? id;
  int? cardId;
  String? serviceName;
  String? description;
  Null? price;
  String? createdAt;
  String? updatedAt;
  List<String>? workingDays;
  WorkingHours? workingHours;
  int? appointmentsPerDay;
  String? expirDate;
  bool? showOnApp;
  Null? image;

  ServiceProvider(
      {this.id,
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
        this.image});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardId = json['card_id'];
    serviceName = json['service_name'];
    description = json['description'];
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
