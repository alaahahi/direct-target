// import 'package:flutter/material.dart';
// import 'package:direct_target/Widgets/ScheduleCard.dart';
// import 'package:get/get.dart';
// class shedule_tab1 extends StatelessWidget {
//   const shedule_tab1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 30),
//
//                 shedule_card(
//                   confirmation: "Confirmed".tr,
//                   mainText: "Dr. Marcus Horizon".tr,
//                   subText: "Cardiologist".tr,
//                   date: "26/06/2022",
//                   time: "10:30 AM",
//                   image: "Assets/icons/male-doctor.png",
//                 ),
//                 const SizedBox(height: 20),
//                 shedule_card(
//                   confirmation: "Confirmed".tr,
//                   mainText: "Dr. Marcus Horizon".tr,
//                   subText: "Cardiologist".tr,
//                   date: "26/06/2022",
//                   time: "2:00 PM",
//                   image: "Assets/icons/female-doctor2.png",
//                 ),
//                 const SizedBox(height: 20),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ScheduleCard.dart';
import 'package:get/get.dart';
import '../../Controller/AppointmentController.dart';
import '../Services/Doctor/edit.dart';
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

            if (appointmentController.appointments!.isEmpty) {
              return const Center(child: Text("No Appointments Found"));
            }

            return ListView.builder(
              itemCount: appointmentController.appointments?.length,
              itemBuilder: (context, index) {
                var appointment = appointmentController.appointments?[index];
                return Column(
                  children: [
                    SizedBox(height: 20),
                    shedule_card(
                      confirmation: appointment!.serviceProviderId?.toString() ?? "Unknown ID",
                      mainText: appointment.serviceProvider!.serviceName!.toString(),
                      subText:  appointment.note ?? "Note",
                      date: appointment.start!,
                      time: appointment.end!,
                      image: "Assets/icons/male-doctor.png",
                      onCancel: () {
                        print("تم إلغاء الموعد!"); // يمكنك استدعاء `setState` أو `showDialog`
                        appointmentController.deleteAppointment(AppointmentId: appointment.id!);
                      },
                      onReschedule: () {
                        print("إعادة جدولة الموعد!");
                        // نقل المعاملات بشكل صحيح

                          Get.to(() => AppointmentScreen(appointmentId: appointment.id!));

                      },

                    ),
                    // SheduleCard(
                    //   confirmation: appointment["status"] ?? "Pending",
                    //   mainText: appointment["doctorName"] ?? "Unknown Doctor",
                    //   subText: appointment["specialization"] ?? "Unknown",
                    //   date: appointment["date"] ?? "Unknown Date",
                    //   time: appointment["time"] ?? "Unknown Time",
                    //   image: "Assets/icons/male-doctor.png", // يمكنك استبداله بالصورة من API
                    // ),
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
