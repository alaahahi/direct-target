
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Api/AppConfig.dart';
import '../Controller/LoaderController.dart';
import '../Model/RequestCardModel.dart';
import '../Model/CardServicesModel.dart';
import '../Controller/TokenController.dart';
class CardServices extends GetConnect {
  static CardServices? _instance;

  var dio = Dio();
  factory CardServices() => _instance ??= CardServices._();

  CardServices._();

  final LoaderController loaderController = Get.find<LoaderController>();

  GetStorage box = GetStorage();
  final tokenController = Get.find<TokenController>();

  Future<RequestCardModel> RequestCard([dynamic data]) async {
    loaderController.loading(true);
    try {
      final res = await dio.post('$appConfig/request-card', data: data);

      if (res.statusCode == 200 || res.statusCode == 201) {
        var responseData = res.data;

        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData); // تحويل النص إلى JSON
          } catch (e) {
            throw Exception('Failed to decode JSON response: $e');
          }
        }

        if (responseData is Map<String, dynamic>) {
          return RequestCardModel.fromJson(responseData);
        } else {
          throw Exception('Unexpected data format: ${responseData.runtimeType}');
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
    } finally {
      loaderController.loading(false);
    }

    return RequestCardModel();
  }




  Future<CardServiceModel> fetchListAllServices(int cardId) async {
    loaderController.loading(true);
    try {
      var res = await dio.get('$appConfig/card-services/active?card_id=1');

      if (res.statusCode == 200 || res.statusCode==201  ) {
        var data = res.data;
        if (data is String) {

          return CardServiceModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {

          return CardServiceModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200 || e.response?.statusCode != 201) {
          print('**********  Error *************${e.response}');
          print('**********  Error *************${e.response?.statusCode}');
        }
      } else {
        print('errorrrrrr $e');
      }

      loaderController.loading(false);
    }
    return CardServiceModel();
  }

}

