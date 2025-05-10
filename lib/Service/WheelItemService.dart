import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:direct_target/Model/WheelWinsModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../Api/AppConfig.dart';
import '../Controller/LoaderController.dart';
import '../Controller/TokenController.dart';
import '../Model/WheelItemModel.dart';
import '../Model/WheelResultModel.dart';
import 'ApiService.dart';


class WheelItemService {
  static WheelItemService? _instance;

  var dio = Dio();
  factory WheelItemService() => _instance ??= WheelItemService._();
  final MyDioService myDioService = MyDioService(Dio());
  final tokenController = Get.find<TokenController>();
  WheelItemService._();

  final LoaderController loaderController = Get.find<LoaderController>();

  GetStorage box = GetStorage();


  Future<WheelResultModel> storeWheelResult([dynamic data]) async {
    try {
      final String token = tokenController.getToken();
      var res = await dio.post(
        '$appConfig/storeWheelResult',
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
        return WheelResultModel.fromJson(res.data);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200) {
          print('**********  Error storeWheelResult *************${e.response}');
        }
      } else {
        print('errorrrrrr WheelItemModel $e');
      }

      loaderController.loading(false);
    }
    return WheelResultModel();
  }
  Future<WheelItemModel> fetchWheelItems([dynamic data]) async {
    loaderController.loading(true);
    final String? language = Get.locale?.languageCode;
    print("Selected Language: $language");
    try {
      var res = await myDioService.fetchDataResponse('$appConfig/wheelItem',
        data: data,
        headers: {
          'Content-Type': 'application/json',
          'Accept-Language': language,
        },
      );

      if (res.statusCode == 200 || res.statusCode==201  ) {
        var data = res.data;
        if (data is String) {
          return WheelItemModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {
          return WheelItemModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200 || e.response?.statusCode != 201) {
          print('**********  Error fetchWheelItems *************${e.response}');
          print('**********  Error fetchWheelItems *************${e.response?.statusCode}');
        }
      } else {
        print('errorrrrrr in fetch $e');
      }

      loaderController.loading(false);
    }
    return WheelItemModel();
  }
  Future<WheelWinsModel> fetchWheelWinItems([dynamic data]) async {
    try {
      final String? language = Get.locale?.languageCode;
      print("Selected Language: $language");
      final String token = tokenController.getToken();

      var res = await myDioService.fetchDataResponse(
        '$appConfig/my-wins',
        data: data,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-Language': language,
        },

      );

      print("Response Status Code: ${res.statusCode}");
      print("Response Data: ${res.data}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        var data = res.data;

        if (data is String) {
          return WheelWinsModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {
          return WheelWinsModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        print("********** Error WheelWinsModel*************");
        print("Response: ${e.response}");
        print("Error Message: ${e.message}");
      } else {
        print('Error in type fetchCard $e');
      }

      loaderController.loading(false);
    }

    return WheelWinsModel();
  }



}
