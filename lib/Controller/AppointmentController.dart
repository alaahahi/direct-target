import 'package:get/get.dart';
import '../Service/AppointmentService.dart';
import 'ProfileCardController.dart';


class AppointmentController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService();

  var isLoading = false.obs;
  var message = ''.obs;

  Future<void> createAppointment(int profileId, String note, String start, String end) async {
    final cardId = Get.put(ProfileCardController()).cardId.value;

    try {
      isLoading(true);

      Map<String, dynamic> appointmentData = {
        'profile_id': profileId,
        'note': note,
        'start': start,
        'end': end,
      };

      final response = await _appointmentService.createAppointment(appointmentData);

      print("API Response: ${response.body}");
      print("Status Code: ${response.statusCode}");
      print("Status Code: ${response.statusCode}");
      if (response.statusCode==201) {
        message.value = response.body ?? 'Appointment created successfully';
        print("Appointment Created: ${response.body}");
      } else {

        print("Response Body: ${response.body}");
        print("card id: ${cardId}");

        print("Error: ${response.body}");
      }
    } catch (e) {
      message.value = 'An error occurred while creating appointment';

      print("Exception: $e");
    } finally {
      isLoading(false);
    }
  }


}