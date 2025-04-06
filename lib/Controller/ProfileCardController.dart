import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/ProfileCardModel.dart';
import '../Model/ProfileUserModel.dart';
import '../Model/UpdateProfileModel.dart';
import '../Routes/Routes.dart';
import '../Service/ApiService.dart';
import '../Service/ProfileCardServices.dart';
import '../Service/ProfileUserServices.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'dart:developer';
import 'package:restart_app/restart_app.dart';
import 'package:dio/dio.dart' as dio;

import 'TokenController.dart';


class ProfileCardController extends GetxController {
  LoaderController loaderController = Get.put(LoaderController());
  final tokenController = Get.find<TokenController>();
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

  final MyDioService dioService = MyDioService(dio.Dio());

  @override
  void onInit() {
    super.onInit();

    loadData();

  }
  Future<void> loadData() async {
    try {
      await dioService.setupDio();
      await Future.wait([
      fetchProfile(),
      fetchCards(),     ]);
    } catch (e) {
      print("Error loading data: $e");
    }
  }


  Future<dynamic> fetchProfile() async {
    try {
      isLoading(true);
      final token = await tokenController.getToken();
      if (token == null || token.isEmpty) {

        loaderController.loading(false);
        return;
      }
      var profileData = await _profileService.fetchProfile();
      profile.value = profileData;
    } catch (e) {
      print("Error: $e");
      msgController.showErrorMessage('Error fetching profile'.tr, e.toString());
    } finally {
      isLoading(false);
    }
  }


  Future<void> fetchCards() async {
    try {
      loaderController.loading(true);
      final token = await tokenController.getToken();
      if (token == null || token.isEmpty) {

        loaderController.loading(false);
        return;
      }
      var response = await ProfileService().fetchCards();
      if (response.data == null || response.data is! List) {
        msgController.showErrorMessage("Error", "Invalid response format. Please login again.");
        loaderController.loading(false);
        return;
      }

      cardsList.assignAll(response.data!);
      print("Cards fetched successfully: ${response.status}");
    } catch (e) {
      log("fetchCards Exception: $e");

      if (e is dio.DioException) {
        msgController.showErrorMessage("Network Error", e.message ?? "Unknown error");
      } else {
        msgController.showErrorMessage("Error", "Something went wrong.");
      }
    } finally {
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