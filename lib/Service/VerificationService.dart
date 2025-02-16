import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Api/AppConfig.dart';
import '../Model/VerificationResponse.dart';
import '../Controller/LoaderController.dart';
class VerificationService {
  var dio = Dio();

  final LoaderController loaderController = Get.find<LoaderController>();
  GetStorage box = GetStorage();
  Future<VerificationResponse> sendVerification(String phoneNumber) async {
    loaderController.loading(true);

    try {
      var res = await dio.post('$appConfig/send-verification-code?phone_number=$phoneNumber');

      if (res.statusCode == 200) {
        loaderController.loading(false);
        return VerificationResponse.fromJson(res.data);
      } else {
        loaderController.loading(false);
        print('Error: ${res.statusCode}');
        return VerificationResponse(message: '');
      }
    } catch (e) {
      loaderController.loading(false);
      if (e is DioException) {
        print('Dio Exception: ${e.response}');
      } else {
        print('Unexpected Error: $e');
      }
      return VerificationResponse(message: '');
    }
  }

  Future<VerificationResponse> verifyCode(String phoneNumber, String code) async {
    final response = await dio.get('$appConfig/verify-code', queryParameters: {
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
