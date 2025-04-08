import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ScheduleCard.dart';
import 'package:get/get.dart';
import '../../../../Controller/AppointmentController.dart';
import 'AppointmentScreen.dart';

class CancelledScheduleScreen extends StatelessWidget {
  CancelledScheduleScreen({super.key});

  final AppointmentController appointmentController = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          if (appointmentController.loaderController.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (appointmentController.appointments.isEmpty) {
            return const Center(child: Text("No Canceled Appointments"));
          }

          var filteredAppointments = appointmentController.appointments
              .where((appointment) {
            return appointment.isCome == 0;
          })
              .toList();

          if (filteredAppointments.isEmpty) {
            return const Center(child: Text("No Canceled Appointments"));
          }

          return ListView.builder(
            itemCount: filteredAppointments.length,
            itemBuilder: (context, index) {
              var appointment = filteredAppointments[index];
              return Column(
                children: [
                  SizedBox(height: 20),
                  shedule_card(
                    mainText: appointment.serviceProvider!.serviceName!.toString(),
                    subText: appointment.note ?? "Note",
                    date: appointment.start!,
                    image: "Assets/images/person.jpg",
                    onCancel: () {
                      appointmentController.deleteAppointment(AppointmentId: appointment.id!);
                    },
                    onReschedule: () {
                      Get.to(() => AppointmentScreen(appointmentId: appointment.id!));
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
