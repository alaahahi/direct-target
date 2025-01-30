import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Service/AppointmentService.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'ProfileCardController.dart';

import 'dart:developer';

import 'package:dio/dio.dart' as dio;



class AppointmentController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService();
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());

  GetStorage box = GetStorage();
  var isLoading = false.obs;
  var message = ''.obs;

  Future<dynamic> createAppointment({required int profileId, required String note, required String start,required String end}) async {
    final cardId = Get.put(ProfileCardController()).cardId.value;
    loaderController.loading(true);
    dio.FormData request =
    dio.FormData.fromMap({'profile_id': profileId, 'note': note,'start':start , 'end':end});
    var response = await AppointmentService().createAppointment(request);
    try {

      msgController.showSuccessMessage(response.status, response.status);
      print("tessssssssssssssssst");
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(e.response?.statusCode.toString() ?? "خطأ غير معروف", e.message ?? "");
      } else {
        msgController.showErrorMessage("خطأ غير معروف", e.toString());
      }
    }
    finally {
      loaderController.loading(false);
    }
  }


}