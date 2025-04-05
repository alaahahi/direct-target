import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/ProfileCardModel.dart';
import '../Model/ProfileUserModel.dart';
import '../Routes/Routes.dart';
import '../Service/ProfileCardServices.dart';
import '../Service/ProfileUserServices.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;


class ProfileCardController extends GetxController {
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  GetStorage box = GetStorage();
  var cardsList = <ProfileData>[].obs;
  var selectedCardId = 0.obs;
  var cardId = 0.obs;
  var isLoading = true.obs;

  var profile = ProfileUserModel().obs;

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
      profile.value = profileData!;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }



  Future<dynamic> fetchCards() async {
    loaderController.loading(true);
    var response = await ProfileService().fetchCards();
    if (response.data != null) {
      cardsList.assignAll(response.data!);
    } else {
      print("⚠️ response.data is null");
      cardsList.clear();
    }

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
        'Your profile has been modified'.tr,
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
}