class VerificationResponse {
  final String message;
  final String status;

  VerificationResponse({required this.message, required this.status});

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    return VerificationResponse(
      message: json['message'],
      status: json['status'],
    );
  }
}


class VerifyCodeResponse {
  String? message;
  String? token;
  String? tokenType;
  int? expiresIn;
  User? user;
  bool? isAdmin;

  VerifyCodeResponse(
      {this.message,
        this.token,
        this.tokenType,
        this.expiresIn,
        this.user,
        this.isAdmin});

  VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['is_admin'] = this.isAdmin;
    return data;
  }
}

class User {
  int? id;
  Null? name;
  String? createdAt;
  String? updatedAt;
  Null? typeId;
  String? phoneNumber;
  String? verificationDate;
  String? verificationUserType;

  User(
      {this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.typeId,
        this.phoneNumber,
        this.verificationDate,
        this.verificationUserType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
    phoneNumber = json['phone_number'];
    verificationDate = json['verification_date'];
    verificationUserType = json['verification_user_type'];
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
    return data;
  }
}

