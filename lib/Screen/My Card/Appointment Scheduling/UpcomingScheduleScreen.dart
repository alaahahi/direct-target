import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ScheduleCard.dart';
import 'package:get/get.dart';

import '../../../../Controller/AppointmentController.dart';
import 'AppointmentDetailsScreen.dart';
import 'AppointmentScreen.dart';



class UpcomingScheduleScreen extends StatelessWidget {
  UpcomingScheduleScreen({super.key});

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
            print("Appointments List: ${appointmentController.appointments.length}");
            return FutureBuilder(
              future: Future.delayed(Duration(seconds: 5), () => appointmentController.appointments.isEmpty),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return  Center(child: Text("No Appointments Found".tr));
              },
            );
          }
          print("Appointmentsssssssssssss List: ${appointmentController.appointments.length}");

          // if (appointmentController.appointments.isEmpty) {
          //   return const Center(child: Text("No Appointments Found"));
          // }

          var filteredAppointments = appointmentController.appointments
              .where((appointment) => appointment.isCome == 1)
              .toList();

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

                    image:"Assets/images/person.jpg",
                    onCancel: () {
                      appointmentController.deleteAppointment(AppointmentId: appointment.id!);
                    },
                    onReschedule: () {
                      Get.to(() => AppointmentDetailsScreen(appointmentId: appointment.id!));
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
