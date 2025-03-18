import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '../Routes/Routes.dart';
import '../Service/VerificationWhatsappService.dart';
import 'ProfileCardController.dart';
import 'TokenController.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class VerificationWhatsappController extends GetxController {
  final VerificationService _verificationService = VerificationService();
  var isLoading = false.obs;
  var message = ''.obs;
  var name = ''.obs;
  var token = ''.obs;
  var network = ''.obs;
  var device = ''.obs;
  var phoneNumber = ''.obs;
  var isAdmin = false.obs;
  final box = GetStorage();
  final tokenController = Get.put(TokenController());
  final ProfileCardController _profileController = Get.put(ProfileCardController());

  @override
  void onInit() {
    getFirebaseToken();
    getNetworkType();
    getDeviceInfo();
    super.onInit();
  }

  Future<void> getFirebaseToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      token.value = fcmToken;
    }
  }


  Future<void> getNetworkType() async {
    List<ConnectivityResult> results = await Connectivity().checkConnectivity();
    String networkType = _getNetworkString(results.isNotEmpty ? results.first : ConnectivityResult.none);

    if (results.first == ConnectivityResult.wifi) {
      NetworkInfo networkInfo = NetworkInfo();
      String? wifiName = await networkInfo.getWifiName();
      if (wifiName != null) {
        network.value = wifiName;
      } else {
        network.value = "Wi-Fi (No SSID found)";
      }
    } else {
      network.value = networkType;
    }

    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) async {
      if (results.first == ConnectivityResult.wifi) {
        NetworkInfo networkInfo = NetworkInfo();
        String? wifiName = await networkInfo.getWifiName();
        network.value = wifiName ?? "Wi-Fi (No SSID found)";
      } else {
        network.value = _getNetworkString(results.first);
      }
    });
  }

  String _getNetworkString(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return "Wi-Fi";
      case ConnectivityResult.mobile:
        return "Mobile Data";
      case ConnectivityResult.ethernet:
        return "Ethernet";
      case ConnectivityResult.none:
        return "No Internet";
      default:
        return "Unknown";
    }
  }


  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device.value = "${androidInfo.name}";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      device.value = "Apple ${iosInfo.name}";
    }
  }


  Future<void> verifyCode(String verificationCode, BuildContext context) async {
    isLoading.value = true;
    final formattedPhoneNumber = formatPhoneNumber(phoneNumber.value);

    try {
      final response = await _verificationService.verifyCode(formattedPhoneNumber, verificationCode);
      if (response.message == "تم التحقق بنجاح.") {
        message.value = response.message!;
        if (response.user?.phoneNumber != null) {
          phoneNumber.value = response.user!.phoneNumber!;
          box.write('phoneNumber', phoneNumber);
        } else {
          phoneNumber.value = 'defaultPhoneNumber';
        }
        bool isAdmin = response.isAdmin ?? false;
        box.write('isAdmin', isAdmin);
        String userPhone = response.user?.phoneNumber ?? "رقم غير متوفر";
         name.value= response.user?.name ?? "اسم غير متوفر";
        token.value= response.token! ;
        print("User Phone: $userPhone");
        print("User Name: $name");
        print("network Name: $network");
        print("device Name: $device");

        box.write('token', token.value);

        print("Token: ${token.value}");
        await _profileController.updateProfile({
          "name": name.value,
          "token": token.value,
          "network": network.value,
          "device": device.value
        });
        if (token.isNotEmpty) {
          tokenController.saveToken(token.value);
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
        duration: Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }





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
  Future<void> logout() async {
    box.remove('token');
    token.value = '';
    isAdmin.value = false;
    print("User logged out");
    Get.offAllNamed(AppRoutes.signinscreen);
  }
}


