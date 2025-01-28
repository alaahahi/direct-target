import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Api/Api.dart';
import '../Controller/LoaderController.dart';

import '../Model/RequestCardModel.dart';
import '../Model/CardServicesModel.dart';
import 'package:http/http.dart' as http;
class CardServices {
  static CardServices? _instance;


  var dio = Dio();
  factory CardServices() => _instance ??= CardServices._();

  CardServices._();

  final LoaderController loaderController = Get.find<LoaderController>();

  GetStorage box = GetStorage();
  static const String baseUrl = "https://dowalyplus.aindubaico.com/api/v1";

  Future<RequestCardModel?> RequestCard([dynamic data]) async {
    loaderController.loading(true);
    try {
      final response = await Api().dio.post('/request-card',data:data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RequestCardModel.fromJson(response.data);
      } else {
        Get.snackbar("Error", "Failed to submit request: ${response.data}");

      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");

    }
    return RequestCardModel();
  }

  Future<List<CardService>> fetchActiveCardServices(int cardId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/card-services/active?card_id=$cardId'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List services = jsonData['data'];

      return services.map((service) => CardService.fromJson(service)).toList();
    } else {
      throw Exception("Failed to load card services");
    }
  }
}
