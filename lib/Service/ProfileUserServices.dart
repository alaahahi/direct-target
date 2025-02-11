import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  final String tokenn = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rvd2FseXBsdXMuYWluZHViYWljby5jb20vYXBpL3YxL3ZlcmlmeS1jb2RlIiwiaWF0IjoxNzM3OTAwMjIwLCJleHAiOjE3NDMwODQyMjAsIm5iZiI6MTczNzkwMDIyMCwianRpIjoiYklJdVh6R3FWTWhOOXRZdyIsInN1YiI6IjI3NSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mMu9oC2cyafur7_KhHfrEAPBc2LyN1RReXQEU594CXI";

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
            'Authorization': 'Bearer $tokenn',
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
          print('**********  Error *************${e.response}');
        }
      } else {
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }

    return ProfileUserModel();
  }
}