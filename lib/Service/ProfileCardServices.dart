import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../Controller/TokenController.dart';
import '../Model/ProfileCardModel.dart';


class Profileservices {
  final Dio _dio = Dio();
  final String apiUrl = 'https://dowalyplus.aindubaico.com/api/v1/cards/me';
  final String tokenn = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rvd2FseXBsdXMuYWluZHViYWljby5jb20vYXBpL3YxL3ZlcmlmeS1jb2RlIiwiaWF0IjoxNzM3OTAwMjIwLCJleHAiOjE3NDMwODQyMjAsIm5iZiI6MTczNzkwMDIyMCwianRpIjoiYklJdVh6R3FWTWhOOXRZdyIsInN1YiI6IjI3NSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mMu9oC2cyafur7_KhHfrEAPBc2LyN1RReXQEU594CXI'; // استبدل بـ Token الحقيقي
  final tokenController = Get.find<TokenController>();


  Future<List<ProfileData>> fetchCards() async {
    final String token = tokenController.getToken();
    print('Saved token: $token');
    try {
      final response = await _dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $tokenn',
          },
        ),
      );

      if (response.statusCode == 200) {
        // استخراج البيانات من JSON
        ProfileModel cardModel = ProfileModel.fromJson(response.data);
        return cardModel.data ?? []; // إعادة قائمة الكروت
      } else {
        throw Exception('Failed to load cards: ${response.statusMessage}');
      }
    } catch (e) {
      print("Error fetching cards: $e");
      throw Exception("Failed to load cards");
    }
  }

  final String updateProfileUrl = 'https://dowalyplus.aindubaico.com/api/v1/profile/update';

  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    final String token = tokenController.getToken();
    print('Saved token: $token');
    try {
      final response = await _dio.post(
        updateProfileUrl,
        data: profileData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully!");
        return true;
      } else {
        print("Failed to update profile: ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }
}

