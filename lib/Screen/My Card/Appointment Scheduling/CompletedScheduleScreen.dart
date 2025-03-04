import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ScheduleCard.dart';
import 'package:get/get.dart';
import '../../../../Controller/AppointmentController.dart';


class CompletedScheduleScreen extends StatelessWidget {
  CompletedScheduleScreen({super.key});

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
            return const Center(child: Text("No Completed Appointments"));
          }
          var filteredAppointments = appointmentController.appointments
              .where((appointment) {
            return appointment.isCome == 2;
          })
              .toList();

          if (filteredAppointments.isEmpty) {
            return const Center(child: Text("No Completed Appointments"));
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
                    image: "Assets/images/person.png",

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
