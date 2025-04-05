
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/ProfileUserModel.dart';
import '../Service/ProfileUserServices.dart';
import 'package:flutter/material.dart';
import '../Routes/Routes.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
class ProfileUserController extends GetxController {
  var isLoading = true.obs;
  var profile = ProfileUserModel().obs;
  LoaderController loaderController = Get.put(LoaderController());
  final ProfileUserService _profileService = ProfileUserService();
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  var token = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }
  final box = GetStorage();
  void fetchProfile() async {
    try {
      isLoading(true);


      var profileData = await _profileService.fetchProfile();
      profile.value = profileData!;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }


  Future<dynamic> deleteProfile({required String phoneNumber, required String verificationCode,required String sms}) async {
    loaderController.loading(true);
    dio.FormData request = dio.FormData.fromMap({'phone_number': phoneNumber,'verification_code':verificationCode,'sms':sms=='sms' ? 1 : 0});
    var response = await ProfileUserService().deleteProfile(request);
    try {
      Get.snackbar(
        'Success',
        'The account has been deleted.'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
      box.remove('token');
      token.value = '';
      print("User logged out");
      Get.offAllNamed(AppRoutes.signinscreen);
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(e.response?.statusCode.toString() ??   'Unknown error'.tr, e.message ?? "");
      } else {
        msgController.showErrorMessage(  'Unknown error'.tr, e.toString());
      }
    }
    finally {
      loaderController.loading(false);
    }
  }
}
