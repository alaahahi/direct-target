// import 'package:flutter/material.dart';
// import 'package:direct_target/Widgets/DoctorList.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:direct_target/Utils/AppStyle.dart';
// import 'package:get/get.dart';
// import '../../../Controller/AppointmentController1.dart';
// import '../../../Controller/CardServiceController.dart';
// import '../../../Controller/LoaderController.dart';
// import '../../../Controller/ProfileCardController.dart';
// import '../../../Model/AppointmentModel.dart';
// import 'SearchScreen.dart';
// import 'package:intl/intl.dart';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class AppointmentEditPage extends StatefulWidget {
//   final int appointmentId;
//
//   AppointmentEditPage({required this.appointmentId});
//
//   @override
//   _AppointmentEditPageState createState() => _AppointmentEditPageState();
// }
//
// class _AppointmentEditPageState extends State<AppointmentEditPage> {
//   final AppointmentController controller = Get.put(AppointmentController());
//
//   final TextEditingController noteController = TextEditingController();
//   DateTime? startDate;
//   DateTime? endDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchAppointmentData();
//   }
//
//   Future<void> _fetchAppointmentData() async {
//     final appointment = await controller.fetchAppointmentById(widget.appointmentId);
//
//     if (appointment != null) {
//       setState(() {
//         noteController.text = appointment.note ?? "";
//         if (appointment.start != null) startDate = appointment.start! as DateTime?;
//         if (appointment.end != null) endDate = appointment.end! as DateTime?;
//       });
//     } else {
//       print("فشل في جلب بيانات الموعد.");
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(
//                 context,
//                 PageTransition(
//                     type: PageTransitionType.fade, child: doctor_search()));
//           },
//           child: Container(
//             height: 10,
//             width: 10,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("Assets/icons/back1.png"),
//                 )),
//           ),
//         ),
//         title: Text(
//           "Book Appointment".tr,
//           style:  Theme.of(context).textTheme.bodyLarge,
//         ),
//         centerTitle: true,
//         elevation: 0,
//         toolbarHeight: 100,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Container(
//               height: 10,
//               width: 10,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("Assets/icons/more.png"),
//                   )),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('رقم الموعد: ${widget.appointmentId}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 20),
//
//             TextField(
//               controller: noteController,
//               decoration: InputDecoration(labelText: 'ملاحظة'),
//             ),
//             SizedBox(height: 20),
//
//             ListTile(
//               title: Text('تاريخ البداية: ${startDate?.toLocal()}'),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () async {
//                 final pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: startDate ?? DateTime.now(),
//                   firstDate: DateTime(2020),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     startDate = pickedDate;
//                   });
//                 }
//               },
//             ),
//
//             ListTile(
//               title: Text('تاريخ الانتهاء: ${endDate?.toLocal()}'),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () async {
//                 final pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: endDate ?? DateTime.now(),
//                   firstDate: DateTime(2020),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     endDate = pickedDate;
//                   });
//                 }
//               },
//             ),
//
//             SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: () {
//                 if (noteController.text.isNotEmpty || startDate != null || endDate != null) {
//                   // controller.updateAppointment(
//                   //   // appointmentId: widget.appointmentId,
//                   //   // note: noteController.text.isEmpty ? null : noteController.text,
//                   //   // start: startDate,  // لا حاجة للتحقق إذا كان فارغًا
//                   //   // end: endDate,      // نفس الشيء هنا
//                   // );
//                 } else {
//                   Get.snackbar('تنبيه', 'يرجى إدخال ملاحظة أو تعديل التاريخ');
//                 }
//               },
//               child: Text('تحديث الموعد'),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
