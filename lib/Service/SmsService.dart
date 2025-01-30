import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class SmsService {
  static Dio dio = Dio(BaseOptions(baseUrl: 'https://dowalyplus.aindubaico.com'));

  static Future<Response> sendOtpAndToken(String phoneNumber, String otp, String firebaseToken) async {
    try {
      Response response = await dio.post(
        '/api/v1/verify-code-sms',
        data: {
          'phone_number': phoneNumber,
          'verification_code': otp,
          'firebase_token': firebaseToken,
          'sms': 1,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Success: ${response.data}');
        String token = response.data['token'];

        final box = GetStorage();
        box.write('token', token);
      } else {
        print('Failed with status code: ${response.statusCode}, body: ${response.data}');
      }
      return response;
    } catch (e) {
      print('Error sending OTP and token: $e');
      rethrow;
    }
  }

}
