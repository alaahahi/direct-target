// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Controller/AppointmentController1.dart';
// import '../../Model/AppointmentModel.dart'; // تأكد من استيراد نموذج الموعد
//
// class EditAppointmentScreen extends StatefulWidget {
//   final AppointmentModel appointment; // استلام بيانات الموعد
//
//   const EditAppointmentScreen({super.key, required this.appointment});
//
//   @override
//   _EditAppointmentScreenState createState() => _EditAppointmentScreenState();
// }
//
// class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
//   final AppointmentController appointmentController = Get.find();
//   late TextEditingController dateController;
//   late TextEditingController timeController;
//
//   @override
//   void initState() {
//     super.initState();
//     dateController = TextEditingController(text: widget.appointment ?? "");
//     timeController = TextEditingController(text: widget.appointment.time ?? "");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Appointment")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: dateController,
//               decoration: const InputDecoration(labelText: "Date"),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: timeController,
//               decoration: const InputDecoration(labelText: "Time"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // تحديث بيانات الموعد
//                 appointmentController.updateAppointment(
//                   appointmentId: widget.appointment.id!,
//                   newDate: dateController.text,
//                   newTime: timeController.text,
//                 );
//
//                 Get.back(); // الرجوع إلى الشاشة السابقة بعد التعديل
//               },
//               child: const Text("Save Changes"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
