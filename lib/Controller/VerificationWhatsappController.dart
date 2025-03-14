import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Routes/Routes.dart';
import '../Screen/Home/NavigationBar/NavigationBarScreen.dart';
import '../Service/VerificationWhatsappService.dart';
import 'TokenController.dart';

class VerificationWhatsappController extends GetxController {
  final VerificationService _verificationService = VerificationService();
  var isLoading = false.obs;
  var message = ''.obs;
  var token = ''.obs;
  var phoneNumber = ''.obs;
  var isAdmin = false.obs;
  final box = GetStorage();
  final tokenController = Get.put(TokenController());
  Future<void> sendVerificationCode(String phoneNumber, BuildContext context) async {
    isLoading.value = true;
    this.phoneNumber.value = phoneNumber;
    try {
      final response = await _verificationService.sendVerificationCode(phoneNumber);
      message.value = response.message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إرسال الرمز بنجاح'.tr),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
      Get.toNamed('/verify');
    } catch (e) {
      message.value = 'Error: $e';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء إرسال الرمز: $e'.tr),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(' ', '').replaceAll('-', '').trim();
  }
  Future<void> verifyCode(String verificationCode, BuildContext context) async {
    isLoading.value = true;
    final formattedPhoneNumber = formatPhoneNumber(phoneNumber.value);

    try {
      final response = await _verificationService.verifyCode(formattedPhoneNumber, verificationCode);

      if (response.message == "تم التحقق بنجاح.") {
        message.value = response.message!;
        token.value = response.token!;

        if (response.user?.phoneNumber != null) {
          phoneNumber.value = response.user!.phoneNumber!;
          box.write('phoneNumber', phoneNumber);
        } else {
          phoneNumber.value = 'defaultPhoneNumber';
        }

        bool isAdmin = response.isAdmin ?? false;
        box.write('isAdmin', isAdmin);
        String userPhone = response.user?.phoneNumber ?? "رقم غير متوفر";
        String userName = response.user?.name ?? "اسم غير متوفر";

        print("User Phone: $userPhone");
        print("User Name: $userName");
        box.write('token', token.value);
        print("Token: ${token.value}");
        if (token.isNotEmpty) {
          tokenController.saveToken(token);
          Get.offAllNamed(AppRoutes.homescreen);
        }

      } else {
        message.value = 'التحقق فشل. الرسالة من السيرفر: ${response.message}';
      }

    } catch (e) {
      message.value = 'Error: $e';
      Get.snackbar(
        'Verification code error'.tr,
          'Please enter the verification code correctly'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> logout() async {
    box.remove('token');
    token.value = '';
    isAdmin.value = false;
    print("User logged out");
    Get.offAllNamed(AppRoutes.signinscreen);
  }
}


