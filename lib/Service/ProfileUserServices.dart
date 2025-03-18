import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../Api/AppConfig.dart';
import '../Controller/TokenController.dart';
import '../Model/ProfileUserModel.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../Controller/LoaderController.dart';

class ProfileUserService extends GetConnect {
  static ProfileUserService? _instance;

  var dio = Dio();
  factory ProfileUserService() => _instance ??= ProfileUserService._();

  ProfileUserService._();

  final LoaderController loaderController = Get.find<LoaderController>();

  GetStorage box = GetStorage();
  final tokenController = Get.find<TokenController>();
  Future<ProfileUserModel> fetchProfile([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.get(
        '$appConfig/profile/me',
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
        if (e.response?.statusCode != 200) {
          print('**********  Error fetchProfile *************${e.response}');
        }
      } else {
        print('errorrrrrr  fetchProfile $e');
      }

      loaderController.loading(false);
    }

    return ProfileUserModel();
  }
}