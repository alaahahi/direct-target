import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ScheduleCard.dart';
import 'package:get/get.dart';
import '../../Controller/AppointmentController.dart';
import '../Services/Doctor/AppointmentScreen.dart';

class SheduleTab1 extends StatelessWidget {
  SheduleTab1({super.key});

  final AppointmentController appointmentController = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(() {
            if (appointmentController.loaderController.loading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (appointmentController.appointments.isEmpty) {
              return FutureBuilder(
                future: Future.delayed(Duration(seconds: 5), () => appointmentController.appointments.isEmpty),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: Text("No Appointments Found"));
                },
              );
            }

// تأكد من أن `appointments` ليست null قبل التحقق من كونها فارغة
            if (appointmentController.appointments == null || appointmentController.appointments!.isEmpty) {
              return const Center(child: Text("No Appointments Found"));
            }


            // Filter appointments where is_come == 1
            var filteredAppointments = appointmentController.appointments!
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

                      image: "Assets/icons/male-doctor.png",
                      onCancel: () {
                        print("تم إلغاء الموعد!");
                        appointmentController.deleteAppointment(AppointmentId: appointment.id!);
                      },
                      onReschedule: () {
                        print("إعادة جدولة الموعد!");
                        // نقل المعاملات بشكل صحيح
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
      ),
    );
  }
}
