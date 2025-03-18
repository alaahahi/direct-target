
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:direct_target/Model/PopularServiceModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Api/AppConfig.dart';
import '../Controller/LoaderController.dart';
import '../Model/AllCardServicesModel.dart';
import '../Model/CardModel.dart';
import '../Model/RequestCardModel.dart';
import '../Model/ServiceModel.dart';
import '../Controller/TokenController.dart';
class CardServices extends GetxService  {
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
            responseData = jsonDecode(responseData);
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
          print('**********  Error RequestCard *************${e.response}');
        }
      } else {
        print('errorrrrrr RequestCard $e');
      }
    } finally {
      loaderController.loading(false);
    }

    return RequestCardModel();
  }
  Future<List<Service>> fetchSearchServices(String searchTerm) async {
    final String? language = Get.locale?.languageCode;
    try {
      var response = await dio.get('$appConfig/card-services/search?search_term=$searchTerm',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept-Language': language,
          },
        ),);

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        var servicesData = response.data['data'] as List;
        return servicesData.map((service) => Service.fromJson(service)).toList();
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error fetching services');
    }
  }
  Future<AllCardServicesModel> fetchListAllServices(int cardId) async {
    loaderController.loading(true);
    final String? language = Get.locale?.languageCode;
    print("Selected Language: $language");
    try {
      var res = await dio.get('$appConfig/card-services/active?card_id=$cardId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept-Language': language,
          },
        ),);

      if (res.statusCode == 200 || res.statusCode==201  ) {
        var data = res.data;
        if (data is String) {
          print("Selected dataaaaaaaaaaaa $data");
          return AllCardServicesModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {
          print(" dataaaaaaaaaaaa $data");
          return AllCardServicesModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode != 200 || e.response?.statusCode != 201) {
          print('**********  Error fetchListAllServices *************${e.response}');
          print('**********  Error fetchListAllServices *************${e.response?.statusCode}');
        }
      } else {
        print('errorrrrrr in fetch $e');
      }

      loaderController.loading(false);
    }
    return AllCardServicesModel();
  }
  Future<CardModel> fetchCard([dynamic data]) async {
    try {
      final String? language = Get.locale?.languageCode;
      print("Selected Language: $language");

      var res = await dio.get(
        '$appConfig/cards/active',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept-Language': language,
          },
        ),
      );

      print("Response Status Code: ${res.statusCode}");
      print("Response Data: ${res.data}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        var data = res.data;

        if (data is String) {
          return CardModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {
          return CardModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        print("********** Error fetchCard*************");
        print("Response: ${e.response}");
        print("Error Message: ${e.message}");
      } else {
        print('Error in type $e');
      }

      loaderController.loading(false);
    }

    return CardModel();
  }
  Future<PopularServiceModel?> fetchPopularService([dynamic data]) async {
    final String? language = Get.locale?.languageCode;
    print("Selected Language: $language");
    try {
      var res = await dio.get(
        '$appConfig/get-popular-service',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept-Language': language,
          },
        ),
      );

      print("Response Status Code: ${res.statusCode}");
      print("Response Data: ${res.data}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        var data = res.data;

        if (data is String) {
          return PopularServiceModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {
          return PopularServiceModel.fromJson(data);
        } else {
          throw Exception('Unexpected data format');
        }
      }
    } catch (e) {
      if (e is DioException) {
        print("**********  Error fetchPopularService*************");
        print("Response: ${e.response}");
        print("Error Message: ${e.message}");
      } else {
        print('Error in type: $e');
      }
    }

    return PopularServiceModel();
  }


}

