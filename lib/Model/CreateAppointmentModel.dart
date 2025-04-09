class CreateAppointmentModel {
  String? status;
  String? message;
  Appointment? appointment;

  CreateAppointmentModel({this.status, this.message, this.appointment});

  CreateAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    appointment = json['appointment'] != null
        ? new Appointment.fromJson(json['appointment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.appointment != null) {
      data['appointment'] = this.appointment!.toJson();
    }
    return data;
  }
}

class Appointment {
  String? serviceProviderId;
  int? userId;
  int? cardId;
  String? note;
  String? start;
  String? end;
  String? updatedAt;
  String? createdAt;
  int? id;

  Appointment(
      {this.serviceProviderId,
        this.userId,
        this.cardId,
        this.note,
        this.start,
        this.end,
        this.updatedAt,
        this.createdAt,
        this.id});

  Appointment.fromJson(Map<String, dynamic> json) {
    serviceProviderId = json['service_provider_id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    note = json['note'];
    start = json['start'];
    end = json['end'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_provider_id'] = this.serviceProviderId;
    data['user_id'] = this.userId;
    data['card_id'] = this.cardId;
    data['note'] = this.note;
    data['start'] = this.start;
    data['end'] = this.end;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
