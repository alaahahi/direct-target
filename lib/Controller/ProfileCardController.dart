import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/ProfileCardModel.dart';
import '../Service/ProfileCardServices.dart';
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




  Future<dynamic> fetchCards() async {
    loaderController.loading(true);
    var response = await ProfileService().fetchCards();
    cardsList.assignAll(response.data!);
    try {
      msgController.showSuccessMessage(response.status, response.status);
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
        'تمت العملية بنجاح',
        ':تم تعديل البروفايل الخاص بك'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      return response;
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(e.response?.statusCode.toString() ?? "خطأ غير معروف", e.message ?? "");
      } else {
        msgController.showErrorMessage("خطأ غير معروف", e.toString());
      }
    } finally {
      loaderController.loading(false);
    }
  }

}