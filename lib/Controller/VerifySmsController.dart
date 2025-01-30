import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/SmsModel.dart';
import '../Routes/Routes.dart';
import '../Service/SmsService.dart';




class OtpController extends GetxController {
  RxString otp = ''.obs;
  RxBool isLoading = false.obs;
  late String verificationId;
  late String phoneNumber;
  late String firebaseToken;

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
            Get.offAllNamed(AppRoutes.homescreen);
            print('ssssssssssssssss ${responseData.message}');
          } else {
            print('Error: ${responseData.message}');
          }
        } else {
          print('API Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error occurred: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      print('Please enter a valid 6-digit OTP');
    }
  }
}
