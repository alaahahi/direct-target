import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import '../Api/AppConfig.dart';
import '../Controller/LoaderController.dart';
import '../Controller/TokenController.dart';
import '../Model/ProfileCardModel.dart';
import '../Model/UpdateProfileModel.dart';
import 'ApiService.dart';


class ProfileService extends GetConnect {
  static ProfileService? _instance;
  // final String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rvd2FseXBsdXMuYWluZHViYWljby5jb20vYXBpL3YxL3ZlcmlmeS1jb2RlIiwiaWF0IjoxNzM3OTAwMjIwLCJleHAiOjE3NDMwODQyMjAsIm5iZiI6MTczNzkwMDIyMCwianRpIjoiYklJdVh6R3FWTWhOOXRZdyIsInN1YiI6IjI3NSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mMu9oC2cyafur7_KhHfrEAPBc2LyN1RReXQEU594CXI';

  var dio = Dio();
  factory ProfileService() => _instance ??= ProfileService._();

  ProfileService._();

  final LoaderController loaderController = Get.find<LoaderController>();
  final MyDioService myDioService = MyDioService(Dio());
  GetStorage box = GetStorage();
  final tokenController = Get.find<TokenController>();

  Future<ProfileModel> fetchCards([dynamic data]) async {
    try {
      if (!Hive.isBoxOpen('cacheBox')) {
        await myDioService.setupDio();
      }

      final String token = tokenController.getToken();
      final String? language = Get.locale?.languageCode;
      int retryCount = 0;
      while (retryCount < 3) {
        var res = await myDioService.fetchDataResponse(
          '$appConfig/cards/me',
          data: data,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept-Language': language,
          },
        );

        if (res.statusCode == 200 || res.statusCode == 201) {
          var data = res.data;
          if (data is String) {
            return ProfileModel.fromJson(jsonDecode(data));
          } else if (data is Map<String, dynamic>) {
            return ProfileModel.fromJson(data);
          } else {
            throw Exception('Unexpected data format');
          }
        } else if (res.statusCode == 429) {
          print('⚠️ Too many requests (429) - Retrying in 2 seconds...');
          await Future.delayed(Duration(seconds: 2));
          retryCount++;
        } else {
          throw Exception('Unexpected status code: ${res.statusCode}');
        }
      }
    } catch (e) {
      print('⚠️ خطأ أثناء جلب البيانات: $e');
    }

    return ProfileModel();
  }



  Future<UpdateProfileModel> updateProfile([dynamic data]) async {
    loaderController.loading(true);
    try {
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

      if (res.statusCode == 200 || res.statusCode == 201) {
        var responseData = res.data;
        if (responseData is String) {
          return UpdateProfileModel.fromJson(jsonDecode(responseData));
        } else if (responseData is Map<String, dynamic>) {
          return UpdateProfileModel.fromJson(responseData);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200) {
          print('********** Error updateProfile *************${e.response}');
        }
      } else {
        print('errorrrrrr updateprofile $e');
      }
    } finally {
      loaderController.loading(false);
    }
    return UpdateProfileModel();
  }
}