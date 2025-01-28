
class VerifySmsModel {
String? message;
String? token;
String? tokenType;
int? expiresIn;

VerifySmsModel({this.message, this.token, this.tokenType, this.expiresIn});

VerifySmsModel.fromJson(Map<String, dynamic> json) {
message = json['message'];
token = json['token'];
tokenType = json['token_type'];
expiresIn = json['expires_in'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['message'] = this.message;
data['token'] = this.token;
data['token_type'] = this.tokenType;
data['expires_in'] = this.expiresIn;
return data;
}
}