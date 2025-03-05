import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/SmsModel.dart';
import '../Routes/Routes.dart';
import '../Service/SmsService.dart';
import 'package:get_storage/get_storage.dart';


class OtpController extends GetxController {
  RxString otp = ''.obs;
  RxBool isLoading = false.obs;
  late String verificationId;
  late String phoneNumber;
  late String firebaseToken;
  var isAdmin = false.obs;
  void setVerificationData(String verificationId, String phoneNumber, String firebaseToken) {
    this.verificationId = verificationId;
    this.phoneNumber = phoneNumber;
    this.firebaseToken = firebaseToken;
  }

  Future<void> verifyOtp(String otp) async {
    if (otp.length == 6) {
      try {
        isLoading.value = true;

        final credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp.trim(),
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        final response = await SmsService.sendOtpAndToken(
          phoneNumber,
          otp,
          firebaseToken,

        );


        if (response.statusCode == 200) {
          SmsModel responseData = SmsModel.fromJson(response.data);
          if (responseData.message == 'تم التحقق بنجاح.') {
            print('Verification successful: ${responseData.message}');
            final box = GetStorage();
            box.write('token', firebaseToken);
            box.write('isAdmin', responseData.isAdmin ?? false);
            print('is Admin ${responseData.isAdmin}');
            Get.offAllNamed(AppRoutes.homescreen);

            print('successful ${responseData.message}');
          } else {
            print('Error: ${responseData.message}');
          }
        } else {
          print('API Error: ${response.statusCode}');
        }
      } catch (e) {
        Get.snackbar(
          'خطأ في رمز التحقق',
          ':الرجاء كتابة كود التحقق بشكل صحيح'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        print('Error occurred: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      print('Please enter a valid 6-digit OTP');
    }
  }
}
