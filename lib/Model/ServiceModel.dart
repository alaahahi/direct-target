class Service {
  final String serviceName;
  final String description;
  final String specialty;
  final String image;
  final String price;
  final String currency;
  int? id;
  int? cardId;
  int? appointmentsPerDay;
  String? expirDate;
  bool? showOnApp;
  String? reviewRate;
  int? exYear;
  int? appointmentsCount;
  Service({
    required this.serviceName,
    required this.description,
    required this.specialty,
    required this.image,
    required this.price,
    required this.currency,
    this.id,
    this.cardId,
    this.appointmentsPerDay,
    this.expirDate,
    this.showOnApp,
    this.reviewRate,
    this.exYear,
    this.appointmentsCount
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName: json['service_name'],
      description: json['description'],
      specialty: json['specialty'],
      image: json['image'],
      price: json['price'],
      currency: json['currency'],
      id: json['id'],
        reviewRate :json['review_rate'],
    );
  }
}
