
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:direct_target/Api/AppConfig.dart';
import 'package:direct_target/Model/BookAppointmentModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Controller/LoaderController.dart';
import '../Controller/TokenController.dart';
import '../Model/AppointmentModel.dart';


class AppointmentService extends GetConnect {
  static AppointmentService? _instance;

  var dio = Dio();
  factory AppointmentService() => _instance ??= AppointmentService._();

  AppointmentService._();

  final LoaderController loaderController = Get.find<LoaderController>();
  GetStorage box = GetStorage();
  final tokenController = Get.find<TokenController>();

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
        print('errorrrrrr $e');
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
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }
    return BookAppointmentModel();
  }
  Future<AppointmentModel> getAppointment([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.get(
        '$appConfig/appointment/me',
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
          print('**********  Error getAppointment *************${e.response}');
        }
      } else {
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }
    return AppointmentModel();
  }
  Future<AppointmentModel> updateAppointment([dynamic data,int? id]) async {
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
        if (e.response?.statusCode != 200 || e.response?.statusCode != 201) {
          print('**********  Error updateAppointment*************${e.response}');
        }
      } else {
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }
    return AppointmentModel();
  }

  Future<AppointmentModel> updateProfile([dynamic data,int? id]) async {
    loaderController.loading(true);
    try {
      final String token = tokenController.getToken();
      var res = await dio.post(
        '$appConfig/appointment/update',
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
          print('**********  Error updateProfile *************${e.response}');
        }
      } else {
        print('errorrrrrr $e');
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
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }
    return AppointmentModel();
  }

}
