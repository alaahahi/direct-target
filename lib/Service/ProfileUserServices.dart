import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/TokenController.dart';
import '../Model/ProfileUserModel.dart';
class ProfileUserService {
  final Dio _dio = Dio();

  final String _baseUrl = "https://dowalyplus.aindubaico.com/api/v1/profile/me";
  final tokenController = Get.find<TokenController>();
  Future<ProfileUserModel?> fetchProfile() async {
    final String token = tokenController.getToken();
    try {
      final response = await _dio.get(_baseUrl,options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),);

      if (response.statusCode == 200) {
        return ProfileUserModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load profile");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
