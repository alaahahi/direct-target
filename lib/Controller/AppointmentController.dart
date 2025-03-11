import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/AppointmentModel.dart';
import '../Routes/Routes.dart';
import '../Screen/My Card/Services Card/DoctorDetailsScreen.dart';
import '../Service/AppointmentService.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'ProfileCardController.dart';
import 'package:http/http.dart' as http;
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

  var appointments = <Appointment>[].obs;

  @override
  void onInit() {
    fetchAppointments();
    super.onInit();
  }

  Future<List<Appointment>> fetchAppointments() async {
    final String token = tokenController.getToken();
    try {
      final response = await http.get(
        Uri.parse("https://dowalyplus.aindubaico.com/api/v1/appointment/me"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          appointments.value = (data['appointment'] as List)
              .map((item) => Appointment.fromJson(item))
              .toList();
          return appointments.value;
        } else {
          throw Exception('فشل في تحميل المواعيد: ${data['message']}');
        }
      } else {
        throw Exception('فشل في تحميل المواعيد، كود الحالة: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('فشل في تحميل المواعيد');
    }
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
  void updateAppointment({required int appointmentId, String? note, String? start, String? end}) async {
    print("Attempting to update appointment: $appointmentId");
    try {
      Map<String, dynamic> updatedFields = {};
      if (note != null) updatedFields['note'] = note;
      if (start != null) updatedFields['start'] = start;
      if (end != null) updatedFields['end'] = end;

      if (updatedFields.isEmpty) {
        Get.snackbar('Alert'.tr, 'No data has been modified'.tr);
        return;
      }

      print("Updated fields: $updatedFields");
      final String token = tokenController.getToken();
      final response = await http.post(
        Uri.parse("https://dowalyplus.aindubaico.com/api/v1/appointment/update/$appointmentId"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedFields),  
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success'.tr, 'Appointment updated successfully'.tr);
        Get.offAllNamed(AppRoutes.appointment);
      } else {
        var data = json.decode(response.body);
        Get.snackbar('Error'.tr, 'Failed to update appointment: ${data['message'] ?? 'Unknown error'.tr}');
      }
    } catch (e) {
      print("Exception: $e");
      Get.snackbar('Error'.tr, 'An error occurred while updating the appointment.'.tr);
    }
  }

  Future<dynamic> createAppointment({required int serviceProviderId,required int profileId, required String note, required String start,required String end}) async {
    final cardId = Get.put(ProfileCardController()).cardId.value;
    loaderController.loading(true);
    dio.FormData request =
    dio.FormData.fromMap({'profile_id': profileId, 'note': note,'start':start , 'end':end,'service_provider_id':serviceProviderId});
    var response = await AppointmentService().createAppointment(request);
    try {
      Get.snackbar(
        'The operation was completed successfully'.tr,
        'The appointment has been booked successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      Get.offAllNamed(AppRoutes.homescreen);
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        Get.snackbar(
          'Operation failed'.tr,
          'Please try again'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
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
    final box = GetStorage();
    loaderController.loading(true);
    update();
    dio.FormData request = dio.FormData.fromMap({'service_id': serviceId});
    var response = await AppointmentService().canBookAppointment(request);
    try {
      if (response.status == "success") {
        int? cardId = response.data?.cardId;
        print("📌 تم تخزين card_id: ${box.read("card_id")}");
        box.write("card_id", cardId);
        Get.to(() => DoctorDetails(doctorId: serviceId));
      } else {
        Get.snackbar('You do not have a card'.tr, 'You have been transferred to request a card so that you can request the service successfully'.tr);
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