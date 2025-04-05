
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:direct_target/Api/AppConfig.dart';
import 'package:direct_target/Model/BookAppointmentModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Controller/LoaderController.dart';
import '../Controller/TokenController.dart';
import '../Model/AppointmentModel.dart';

import 'ApiService.dart';
class AppointmentService extends GetConnect {
  static AppointmentService? _instance;

  var dio = Dio();
  factory AppointmentService() => _instance ??= AppointmentService._();

  AppointmentService._();
  final MyDioService myDioService = MyDioService(Dio());
  final LoaderController loaderController = Get.find<LoaderController>();
  GetStorage box = GetStorage();
  final tokenController = Get.find<TokenController>();
 final String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rvd2FseXBsdXMuYWluZHViYWljby5jb20vYXBpL3YxL3ZlcmlmeS1jb2RlIiwiaWF0IjoxNzM3OTAwMjIwLCJleHAiOjE3NDMwODQyMjAsIm5iZiI6MTczNzkwMDIyMCwianRpIjoiYklJdVh6R3FWTWhOOXRZdyIsInN1YiI6IjI3NSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mMu9oC2cyafur7_KhHfrEAPBc2LyN1RReXQEU594CXI';

  Future<AppointmentModel> getAppointment([dynamic data]) async {
    try {

      final String? language = Get.locale?.languageCode;
      var res = await myDioService.fetchDataResponse(
        '$appConfig/appointment/me',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-Language': language,
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var responseData = res.data;
        if (responseData is String) {
          return AppointmentModel.fromJson(jsonDecode(responseData));
        } else if (responseData is Map<String, dynamic>) {
          return AppointmentModel.fromJson(responseData);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200) {
          print('**********  Error fetchAppointments *************${e.response}');
        }
      } else {
        print('Error fetchAppointments: $e');
      }

      loaderController.loading(false);
    }

    return AppointmentModel();
  }



  Future<AppointmentModel> createAppointment([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.post(
        '$appConfig/appointment/store',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 200 || res.statusCode==201  ) {
        var data = res.data;
        if (data is String) {

          return AppointmentModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {

          return AppointmentModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200 || e.response?.statusCode != 201) {
          print('**********  Error createAppointment *************${e.response}');
        }
      } else {
        print('errorrrrrr createAppointment $e');
      }

      loaderController.loading(false);
    }
    return AppointmentModel();
  }

  Future<BookAppointmentModel> canBookAppointment([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.post(
        '$appConfig/appointment/canBookAppointment',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 200 || res.statusCode==201  ) {
        var data = res.data;
        if (data is String) {

          return BookAppointmentModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {

          return BookAppointmentModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format ');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200 || e.response?.statusCode != 201) {
          print('**********  Error canBookAppointment *************${e.response}');
        }
      } else {
        print('errorrrrrr canBookAppointment $e');
      }

      loaderController.loading(false);
    }
    return BookAppointmentModel();
  }

  Future<AppointmentModel> updateAppointment([dynamic data,int? id]) async {
    loaderController.loading(true);
    try {
      final String token = tokenController.getToken();
      var res = await dio.post(
        '$appConfig/appointment/update/$id',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 200 || res.statusCode==201  ) {
        var data = res.data;
        if (data is String) {

          return AppointmentModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {

          return AppointmentModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200) {
          print('**********  Error updateAppointment*************${e.response}');
        }
      } else {
        print('errorrrrrr updateAppointment $e');
      }

      loaderController.loading(false);
    }
    return AppointmentModel();
  }

  Future<AppointmentModel> deleteAppointment([dynamic data,int? id]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.post(
        '$appConfig/appointment/delete/$id',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 200 || res.statusCode==201  ) {
        var data = res.data;
        if (data is String) {

          return AppointmentModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {

          return AppointmentModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200 || e.response?.statusCode != 201) {
          print('**********  Error deleteAppointment *************${e.response}');
        }
      } else {
        print('errorrrrrr deleteAppointment $e');
      }

      loaderController.loading(false);
    }
    return AppointmentModel();
  }

}
