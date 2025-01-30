import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Api/AppConfig.dart';
import '../Controller/LoaderController.dart';
import '../Controller/TokenController.dart';
import '../Model/ProfileCardModel.dart';
import '../Model/UpdateProfileModel.dart';


class ProfileService extends GetConnect {
  static ProfileService? _instance;

  var dio = Dio();
  factory ProfileService() => _instance ??= ProfileService._();

  ProfileService._();

  final LoaderController loaderController = Get.find<LoaderController>();

  GetStorage box = GetStorage();
  final tokenController = Get.find<TokenController>();

  Future<ProfileModel> fetchCards([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.get(
        '$appConfig/cards/me',
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

          return ProfileModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {

          return ProfileModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200) {
          print('**********  Error *************${e.response}');
        }
      } else {
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }

    return ProfileModel();
  }

  Future<UpdateProfileModel> updateProfile([dynamic data]) async {
    loaderController.loading(true);
    try {
      // var res = await dio.post('$appConfig/profile/update');
      final String token = tokenController.getToken();
      var res = await dio.post(
        '$appConfig/profile/update',
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

          return UpdateProfileModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {

          return UpdateProfileModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200) {
          print('**********  Error *************${e.response}');
        }
      } else {
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }
    return UpdateProfileModel();
  }
}