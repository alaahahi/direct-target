import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/AppointmentModel.dart';
import '../Routes/Routes.dart';
import '../Screen/My Card/Services Card/DoctorDetailsScreen.dart';
import '../Screen/My Card/Services Card/PopularDoctorDetailsScreen.dart';
import '../Service/AppointmentService.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'ProfileCardController.dart';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'TokenController.dart';

class AppointmentController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService();
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  final tokenController = Get.find<TokenController>();
  GetStorage box = GetStorage();
  var isLoading = false.obs;
  var message = ''.obs;
  List<Appointment>? appointmentData = [];
  var appointments = <Appointment>[].obs;

  @override
  void onInit() {
    fetchAppointments();
    super.onInit();
  }
  Future<dynamic> fetchAppointments() async {
    loaderController.loading(true);
    update();
    try {
      var res = await AppointmentService().getAppointment();
      appointmentData = res.appointment!;
      print('Fetched Data Length: ${appointmentData?.length}');
      print('Fetched Data appointmentData : $appointmentData');
      appointments.value = appointmentData!;
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
      } else {
        print('Error fetching data: $e');
      }
    }
    update();
    loaderController.loading(false);
  }



  Future<Appointment?> fetchAppointmentById(int id) async {
    try {
      if (appointments.isEmpty) {
        await fetchAppointments();
      }
      final appointment = appointments.firstWhere(
            (appointment) => appointment.id == id,
      );
      return appointment;
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error'.tr, e.toString());
      return null;
    }
  }
  Future<dynamic> updateAppointment(Map<String, dynamic> appointmentData) async {
    try {
      loaderController.loading(true);
      dio.FormData request = dio.FormData.fromMap(appointmentData);
      var response = await AppointmentService().updateAppointment(request);
    if(response.status == 200 || response.status==201) {
      Get.snackbar(
        'The operation was completed successfully'.tr,
        'Your Appointment has been modified'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
      // Get.offAllNamed(AppRoutes.appointment);
      return response;
    }
    else{
      Get.snackbar(
        'The operation was completed successfully'.tr,
        'Your Appointment has been modified'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    }
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

  Future<dynamic> createAppointment({
    required int serviceProviderId,required int profileId, required String note, required String start,
    required String end,
    String? phone,
    String? cardNumber,
  }) async {
    final cardId = Get.put(ProfileCardController()).cardId.value;
    loaderController.loading(true);
    dio.FormData request =
    dio.FormData.fromMap({'profile_id': profileId, 'note': note,'start':start , 'end':end,'service_provider_id':serviceProviderId
    ,'phone_number':phone ,'card_number':cardNumber});
    var response = await AppointmentService().createAppointment(request);
    try {
      await Future.delayed(Duration(seconds: 1));
      if (response.status == "success") {
        Get.snackbar(
          'The operation was completed successfully'.tr,
          'The appointment has been booked successfully'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );

        await Future.delayed(Duration(seconds: 6));
        Get.back();
      }
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        Get.snackbar(
          'Operation failed'.tr,
          'Please try again'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );      } else {
        msgController.showErrorMessage(  'Unknown error'.tr, e.toString());
      }
    }
    finally {
      loaderController.loading(false);
    }
  }
  Future<dynamic> getAllAppointment() async {
    loaderController.loading(true);
    var response = await AppointmentService().getAppointment();
    try {
    print(response.status);
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
  Future<dynamic> deleteAppointment({required int AppointmentId}) async {
    loaderController.loading(true);
    dio.FormData request = dio.FormData.fromMap({'appointment_id': AppointmentId});
    var response = await AppointmentService().deleteAppointment(request);
    try {
      msgController.showSuccessMessage(response.status, response.status);
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

  Future<dynamic> canBookAppointment({required int serviceId}) async {
    loaderController.loading(true);
    update();
    dio.FormData request = dio.FormData.fromMap({'service_id': serviceId});
    var response = await AppointmentService().canBookAppointment(request);
    try {
      if (response.status == "success") {
        int? cardId = response.data?.cardId;
        print("📌 تم  card_id: ${cardId}");
        print("📌 تم  serviceId: ${serviceId}");
        print("📌 Going to DoctorDetails with doctorId: ${serviceId}");
        Get.to(() => DoctorDetails(doctorId: serviceId));
      }
      else {
        Get.snackbar('You do not have a card'.tr, 'You have been transferred to request a card so that you can request the service successfully'.tr,
            duration: Duration(seconds: 5));
        Get.offAllNamed(AppRoutes.requestcard);
      }
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(
            e.response?.statusCode.toString() ?? 'Unknown error'.tr,
            e.message ?? "");
      } else {
        msgController.showErrorMessage( 'Unknown error'.tr, e.toString());
      }
    } finally {
      loaderController.loading(false);
      update();

    }
  }
  Future<dynamic> canBookPopularAppointment({required int serviceId}) async {
    loaderController.loading(true);
    update();
    dio.FormData request = dio.FormData.fromMap({'service_id': serviceId});
    var response = await AppointmentService().canBookAppointment(request);
    try {
      if (response.status == "success") {
        int? cardId = response.data?.cardId;
        print("📌 تم  card_id: ${cardId}");
        print("📌 تم  serviceId: ${serviceId}");
        print("📌 Going to DoctorDetails with doctorId: ${serviceId}");
        Get.to(() => PopularDoctorDetailsScreen(doctorId: serviceId));
      }
      else {
        Get.snackbar('You do not have a card'.tr, 'You have been transferred to request a card so that you can request the service successfully'.tr,
            duration: Duration(seconds: 5));
        Get.offAllNamed(AppRoutes.requestcard);
      }
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(
            e.response?.statusCode.toString() ?? 'Unknown error'.tr,
            e.message ?? "");
      } else {
        msgController.showErrorMessage( 'Unknown error'.tr, e.toString());
      }
    } finally {
      loaderController.loading(false);
      update();

    }
  }
}