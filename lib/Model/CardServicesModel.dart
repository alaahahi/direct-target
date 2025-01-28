class CardService {
  int id;
  int cardId;
  String serviceName;
  String description;
  String? price;
  List<String> workingDays;
  WorkingHours workingHours;
  int appointmentsPerDay;
  DateTime expiryDate;
  bool showOnApp;
  String? image;
  DateTime createdAt;
  DateTime updatedAt;

  CardService({
    required this.id,
    required this.cardId,
    required this.serviceName,
    required this.description,
    this.price,
    required this.workingDays,
    required this.workingHours,
    required this.appointmentsPerDay,
    required this.expiryDate,
    required this.showOnApp,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardService.fromJson(Map<String, dynamic> json) {
    return CardService(
      id: json['id'],
      cardId: json['card_id'],
      serviceName: json['service_name'],
      description: json['description'],
      price: json['price'],
      workingDays: List<String>.from(json['working_days']),
      workingHours: WorkingHours.fromJson(json['working_hours']),
      appointmentsPerDay: json['appointments_per_day'],
      expiryDate: DateTime.parse(json['expir_date']),
      showOnApp: json['show_on_app'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class WorkingHours {
  String start;
  String end;

  WorkingHours({
    required this.start,
    required this.end,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      start: json['start'],
      end: json['end'],
    );
  }
}

