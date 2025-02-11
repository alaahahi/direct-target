import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/AppointmentModel.dart';
import '../Routes/Routes.dart';
import '../Service/AppointmentService.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'ProfileCardController.dart';
import 'package:http/http.dart' as http;
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

  var appointments = <Appointment>[].obs;
  final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rvd2FseXBsdXMuYWluZHViYWljby5jb20vYXBpL3YxL3ZlcmlmeS1jb2RlIiwiaWF0IjoxNzM3OTAwMjIwLCJleHAiOjE3NDMwODQyMjAsIm5iZiI6MTczNzkwMDIyMCwianRpIjoiYklJdVh6R3FWTWhOOXRZdyIsInN1YiI6IjI3NSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mMu9oC2cyafur7_KhHfrEAPBc2LyN1RReXQEU594CXI";

  @override
  void onInit() {
    fetchAppointments();
    super.onInit();
  }

  Future<List<Appointment>> fetchAppointments() async {
    try {
      final response = await http.get(
        Uri.parse("https://dowalyplus.aindubaico.com/api/v1/appointment/me"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);

        // Check if the response status is success
        if (data['status'] == 'success') {
          // Handle the list of appointments, mapping each item to the Appointment model
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

      if (appointment != null) {
        return appointment;
      } else {
        throw Exception('الموعد غير موجود.');
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('خطأ', e.toString());
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
        Get.snackbar('تنبيه', 'لم يتم تعديل أي بيانات');
        return;
      }

      print("Updated fields: $updatedFields");

      final response = await http.post(
        Uri.parse("https://dowalyplus.aindubaico.com/api/v1/appointment/update/$appointmentId"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedFields),  
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('نجاح', 'تم تحديث الموعد بنجاح');
        Get.offAllNamed(AppRoutes.appointment);
      } else {
        var data = json.decode(response.body);
        Get.snackbar('خطأ', 'فشل في تحديث الموعد: ${data['message'] ?? 'خطأ غير معروف'}');
      }
    } catch (e) {
      print("Exception: $e");
      Get.snackbar('خطأ', 'حدث خطأ أثناء تحديث الموعد');
    }
  }

  Future<dynamic> createAppointment({required int serviceProviderId,required int profileId, required String note, required String start,required String end}) async {
    final cardId = Get.put(ProfileCardController()).cardId.value;
    loaderController.loading(true);
    dio.FormData request =
    dio.FormData.fromMap({'profile_id': profileId, 'note': note,'start':start , 'end':end,'service_provider_id':serviceProviderId});
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



  Future<dynamic> getAllAppointment() async {
    loaderController.loading(true);

    var response = await AppointmentService().getAppointment();
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
  Future<dynamic> deleteAppointment({required int AppointmentId}) async {
    loaderController.loading(true);
    dio.FormData request = dio.FormData.fromMap({'appointment_id': AppointmentId});
    var response = await AppointmentService().deleteAppointment(request);
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