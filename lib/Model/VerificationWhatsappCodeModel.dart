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




