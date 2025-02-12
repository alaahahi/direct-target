import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ScheduleCard.dart';
import 'package:get/get.dart';
import '../../Controller/AppointmentController.dart';
import '../Services/Doctor/AppointmentScreen.dart';

class SheduleTab2 extends StatelessWidget {
  SheduleTab2({super.key});

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
              return const Center(child: Text("No Completed Appointments"));
            }

            // تصفية المواعيد المكتملة
            var filteredAppointments = appointmentController.appointments
                .where((appointment) {
              print("Appointment isCome: ${appointment.isCome}"); // طباعة القيمة للتحقق
              return appointment.isCome == 2; // تأكد من أن القيمة هي 2 للمواعيد المكتملة
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
