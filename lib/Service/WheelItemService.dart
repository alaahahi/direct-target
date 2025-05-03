import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../Api/AppConfig.dart';
import '../Controller/LoaderController.dart';
import '../Model/WheelItemModel.dart';
import 'ApiService.dart';


class WheelItemService {
  static WheelItemService? _instance;

  var dio = Dio();
  factory WheelItemService() => _instance ??= WheelItemService._();
  final MyDioService myDioService = MyDioService(Dio());

  WheelItemService._();

  final LoaderController loaderController = Get.find<LoaderController>();

  GetStorage box = GetStorage();



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
          print("Selected dataaaaaaaaaaaa $data");
          return WheelItemModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {
          print(" dataaaaaaaaaaaa $data");
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

}
