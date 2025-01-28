
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Controller/TokenController.dart';
class AppointmentService extends GetConnect {
  final String baseUrl = 'https://dowalyplus.aindubaico.com/api/v1';

  // Add the token here
  final String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rvd2FseXBsdXMuYWluZHViYWljby5jb20vYXBpL3YxL3ZlcmlmeS1jb2RlIiwiaWF0IjoxNzM3OTAwMjIwLCJleHAiOjE3NDMwODQyMjAsIm5iZiI6MTczNzkwMDIyMCwianRpIjoiYklJdVh6R3FWTWhOOXRZdyIsInN1YiI6IjI3NSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mMu9oC2cyafur7_KhHfrEAPBc2LyN1RReXQEU594CXI';
  final tokenController = Get.find<TokenController>();
  Future<http.Response> createAppointment(Map<String, dynamic> appointmentData) async {
    final String token = tokenController.getToken();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/appointment/store'),
        headers: {
          'Authorization': 'Bearer $token', // Use Bearer token for authentication
          'Content-Type': 'application/json', // Add Content-Type header if needed (usually for POST requests with JSON data)
        },
        body: jsonEncode(appointmentData), // Convert your data into JSON format
      );

      print("API Response: ${response.body}");
      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
