class VerificationResponse {
  final String message;
  final String? token;

  VerificationResponse({required this.message, this.token});

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    return VerificationResponse(
      message: json['message'],
      token: json['token'],
    );
  }
}
