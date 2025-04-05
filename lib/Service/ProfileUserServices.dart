import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../Api/AppConfig.dart';
import '../Controller/TokenController.dart';
import '../Model/ProfileUserModel.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../Controller/LoaderController.dart';
import 'ApiService.dart';

class ProfileUserService extends GetConnect {
  static ProfileUserService? _instance;

  var dio = Dio();
  factory ProfileUserService() => _instance ??= ProfileUserService._();

  ProfileUserService._();

  final LoaderController loaderController = Get.find<LoaderController>();
  final MyDioService myDioService = MyDioService(Dio());
  GetStorage box = GetStorage();
  final tokenController = Get.find<TokenController>();
  Future<ProfileUserModel> fetchProfile([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      final String? language = Get.locale?.languageCode;

      final url = '$appConfig/profile/me';
      print('Requesting: $url');

      var res = await myDioService.fetchDataResponse(
        url,
        data: data,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-Language': language,
        },
      );
      if (res.data is String && res.data.toString().startsWith('<!DOCTYPE')) {
        throw Exception("Received HTML instead of JSON. Check API route or token.");
      }

      print('Status code: ${res.statusCode}');
      print('Response: ${res.data}');

      if (res.statusCode == 200 || res.statusCode == 201) {
        var data = res.data;

        if (data is String) {
          return ProfileUserModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {
          return ProfileUserModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }

    } catch (e) {
      if (e is DioException) {
        print('**********  Error fetchProfile *************${e.response}');
      } else {
        print('errorrrrrr  fetchProfile $e');
      }

      loaderController.loading(false);
    }

    return ProfileUserModel();
  }


  Future<ProfileUserModel> deleteProfile([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.delete(
        '$appConfig/profile/delete',
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

          return ProfileUserModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {

          return ProfileUserModel.fromJson(data);
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
    return ProfileUserModel();
  }
}