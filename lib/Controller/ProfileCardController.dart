import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/ProfileCardModel.dart';
import '../Model/ProfileUserModel.dart';
import '../Model/UpdateProfileModel.dart';
import '../Routes/Routes.dart';
import '../Service/ProfileCardServices.dart';
import '../Service/ProfileUserServices.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'dart:developer';
import 'package:restart_app/restart_app.dart';
import 'package:dio/dio.dart' as dio;
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
import 'package:restart_app/restart_app.dart';

class ProfileCardController extends GetxController {
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  GetStorage box = GetStorage();
  var cardsList = <ProfileData>[].obs;
  var selectedCardId = 0.obs;
  var cardId = 0.obs;
  var profile = ProfileUserModel().obs;
  var isLoading = true.obs;

  var token = ''.obs;
  final ProfileUserService _profileService = ProfileUserService();
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchCards();
  }
  Future<dynamic> fetchProfile() async {
    try {
      isLoading(true);
      var profileData = await _profileService.fetchProfile();
      profile.value = profileData;
    } catch (e) {
      print("Error: $e");
      msgController.showErrorMessage('Error fetching profile'.tr, e.toString());
    } finally {
      isLoading(false);
    }
  }


  Future<dynamic> fetchCards() async {
    loaderController.loading(true);
    var response = await ProfileService().fetchCards();
    cardsList.assignAll(response.data!);
    try {
      print(response.status);
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(response.status, response.status);
      } else {
        msgController.showErrorMessage(response.status, response.status);
      }
      loaderController.loading(false);
    }
  }
  Future<dynamic> updateProfile(Map<String, dynamic> profileData) async {
    try {
      loaderController.loading(true);
      dio.FormData request = dio.FormData.fromMap(profileData);
      var response = await ProfileService().updateProfile(request);
      Get.snackbar(
        'The operation was completed successfully'.tr,
        'success'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

      await fetchProfile();
      Get.offAllNamed(AppRoutes.homescreen);

      return response;
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(e.response?.statusCode.toString() ?? 'Unknown error'.tr, e.message ?? "");
      } else {
        msgController.showErrorMessage('Unknown error'.tr, e.toString());
      }
    } finally {
      loaderController.loading(false);
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
      Restart.restartApp();

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