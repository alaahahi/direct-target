import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../Api/Api.dart';
import '../Model/VerificationResponse.dart';

import '../Controller/LoaderController.dart';
class VerificationService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://dowalyplus.aindubaico.com/api/v1';
  final LoaderController loaderController = Get.find<LoaderController>();
  GetStorage box = GetStorage();
  Future<VerificationResponse> sendVerification(String phoneNumber) async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.post('/send-verification-code?phone_number=$phoneNumber');

      if (res.statusCode == 200) {
        loaderController.loading(false);
        // إرجاع النموذج الذي يحتوي على الرسالة و الـ token
        return VerificationResponse.fromJson(res.data);
      } else {
        loaderController.loading(false);
        print('Error: ${res.statusCode}');
        return VerificationResponse(message: ''); // إرجاع نموذج فارغ أو رسالة خطأ
      }
    } catch (e) {
      loaderController.loading(false);
      if (e is DioException) {
        print('Dio Exception: ${e.response}');
      } else {
        print('Unexpected Error: $e');
      }
      return VerificationResponse(message: ''); // أو إرجاع null
    }
  }

  Future<VerificationResponse> verifyCode(String phoneNumber, String code) async {
    final response = await _dio.get('$baseUrl/verify-code', queryParameters: {
      'phone_number': phoneNumber,
      'verification_code': code,
    });

    if (response.statusCode == 200) {
      return VerificationResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to verify code');
    }
  }
}
