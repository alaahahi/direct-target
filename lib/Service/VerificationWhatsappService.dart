import 'dart:convert';
import '../Model/VerificationWhatsappCodeModel.dart';
import 'package:http/http.dart' as http;

String formatPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAll(' ', '').replaceAll('-', '').trim();
}
class VerificationService {
  final String sendCodeUrl = 'https://dowalyplus.aindubaico.com/api/v1/send-verification-code';
  final String verifyCodeUrl = 'https://dowalyplus.aindubaico.com/api/v1/verify-code';

  Future<VerificationResponse> sendVerificationCode(String phoneNumber) async {
    final formattedPhoneNumber = formatPhoneNumber(phoneNumber);
    print("Formatted phone number: $formattedPhoneNumber");

    final requestBody = {
      'phone_number': formattedPhoneNumber,
    };

    try {
      final response = await http.post(
        Uri.parse(sendCodeUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');


      if (response.statusCode == 200) {
        return VerificationResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to send verification code: ${response.body}');
      }
    } catch (e) {
      print("Error occurreddddd: $e");
      throw Exception('Error during request: $e');
    }
  }

  // Verify the verification code
  Future<VerifyCodeResponse> verifyCode(String phoneNumber, String verificationCode) async {
    print('Phone Number: $phoneNumber');
    print('Verification Code: $verificationCode');

    if (phoneNumber.isEmpty || verificationCode.isEmpty) {
      throw Exception('Phone number and verification code cannot be empty');
    }

    final formattedPhoneNumber = formatPhoneNumber(phoneNumber);
    final requestBody = {
      'phone_number': formattedPhoneNumber,
      'verification_code': verificationCode,
    };

    print('Sending POST request to: $verifyCodeUrl');
    print('Request body: $requestBody');

    try {
      final response = await http.post(
        Uri.parse(verifyCodeUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        return VerifyCodeResponse.fromJson(json.decode(response.body));
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to verify code: ${response.body}');
      }
    } catch (e) {
      print("Error occurred: $e");
      throw Exception('Error during request: $e');
    }
  }


}



