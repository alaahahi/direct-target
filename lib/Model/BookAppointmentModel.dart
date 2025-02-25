class BookAppointmentModel {
  String? status;
  String? message;
  BookAppointmentData? data;

  BookAppointmentModel({this.status, this.message, this.data});

  BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BookAppointmentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BookAppointmentData {
  int? cardId;
  String? serviceId;

  BookAppointmentData({this.cardId, this.serviceId});

  BookAppointmentData.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['service_id'] = this.serviceId;
    return data;
  }
}
