import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class SmsService {
  static Dio dio = Dio(BaseOptions(baseUrl: 'https://dowalyplus.aindubaico.com'));

  // Function to send OTP, phone number, and Firebase token
  static Future<Response> sendOtpAndToken(String phoneNumber, String otp, String firebaseToken) async {
    try {
      Response response = await dio.post(
        '/api/v1/verify-code-sms',
        data: {
          'phone_number': phoneNumber,
          'verification_code': otp,
          'firebase_token': firebaseToken,
          'sms': 1, // أضف هذا إذا كان مطلوبًا في الـ API
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        print('Success: ${response.data}');
        String token = response.data['token'];

        // تخزين التوكين في GetStorage
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
