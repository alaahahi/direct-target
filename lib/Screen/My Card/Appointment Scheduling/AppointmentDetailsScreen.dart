import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Controller/AppointmentController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Widgets/DoctorDetailsList.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final int appointmentId;

  AppointmentDetailsScreen({required this.appointmentId});

  final AppointmentController appointmentController = Get.find();
  final LoaderController loaderController = Get.find();

  String formatTime(String time) {
    try {
      final parsed = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
      return DateFormat("yyyy-MM-dd | HH:mm").format(parsed);
    } catch (e) {
      return time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              size: MediaQuery.of(context).size.height * 0.025,
            ),
          ),

          onPressed: () => Get.back(),
        ),
        title: Text(
            "Appointment Details".tr,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),

      body: GetBuilder<AppointmentController>(
        builder: (controller) {
          if (loaderController.loading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final appointment = controller.appointments.firstWhere(
                  (a) => a.id == appointmentId,
              orElse: () => throw Exception('Appointment not found'.tr));

          final doctor = appointment.serviceProvider;

          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              DoctorDetailsList(
                maintext: doctor?.serviceName ?? 'No Name',
                subtext: doctor?.specialty ?? '',
                image: doctor?.image ?? '',
                firstmaintext: doctor?.reviewRate ?? '0.0',
                secondmaintext: doctor!.exYear!,
                thirdmaintext: doctor!.appointmentsPerDay!,
              ),
              SizedBox(height: 20),
              _buildDetailTile("Note".tr, appointment.note ?? "—"),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.black12,
                  thickness: 1,
                ),
              ),
              _buildDetailTile("Start".tr, formatTime(appointment.start ?? "")),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.black12,
                  thickness: 1,
                ),
              ),
              _buildDetailTile("End".tr, formatTime(appointment.end ?? "")),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.black12,
                  thickness: 1,
                ),
              ),
              _buildDetailTile("Duration".tr, "30 min"),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),

      ),
    );
  }
}
