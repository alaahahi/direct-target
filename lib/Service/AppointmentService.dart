
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:direct_target/Api/AppConfig.dart';
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
  final String tokenn = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rvd2FseXBsdXMuYWluZHViYWljby5jb20vYXBpL3YxL3ZlcmlmeS1jb2RlIiwiaWF0IjoxNzM3OTAwMjIwLCJleHAiOjE3NDMwODQyMjAsIm5iZiI6MTczNzkwMDIyMCwianRpIjoiYklJdVh6R3FWTWhOOXRZdyIsInN1YiI6IjI3NSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mMu9oC2cyafur7_KhHfrEAPBc2LyN1RReXQEU594CXI';
  final tokenController = Get.find<TokenController>();
  Future<AppointmentModel> createAppointment([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.post(
        '$appConfig/appointment/store',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $tokenn',
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
          print('**********  Error *************${e.response}');
        }
      } else {
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }
    return AppointmentModel();
  }

}
