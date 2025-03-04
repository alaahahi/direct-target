import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../../Controller/AppointmentController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Controller/ProfileCardController.dart';
import 'package:intl/intl.dart';
import '../../../Routes/Routes.dart';
import '../../../Widgets/DoctorDetailsList.dart';

class DoctorDetails extends StatefulWidget {
  final int doctorId;
  final int? appointmentId;

  DoctorDetails({required this.doctorId, this.appointmentId});
  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {

  final AppointmentController appointmencontroller =
  Get.put(AppointmentController());
  final TextEditingController noteController = TextEditingController();
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final ProfileCardController profcontroller = Get.put(ProfileCardController());
  LoaderController loaderController = Get.put(LoaderController());
  DateFormat dateFormat = DateFormat("y-MM-dd H:m:s");
  String? selectedDay;
  String? selectedDate;

  String getDateForDay(String day) {
    DateTime today = DateTime.now();
    DateTime nextDay = today;

    while (DateFormat('EEEE').format(nextDay) != day) {
      nextDay = nextDay.add(Duration(days: 1));
    }

    return DateFormat('yyyy-MM-dd').format(nextDay);
  }

  String? selectedTime;

  DateTime parseTime(String timeStr) {
    return DateFormat("HH:mm:ss").parse(timeStr);
  }

  List<String> getAvailableHours(String start, String end) {
    DateTime startDateTime = parseTime(start);
    DateTime endDateTime = parseTime(end);

    List<String> hours = [];

    while (startDateTime.isBefore(endDateTime)) {
      hours.add(DateFormat("HH:mm:ss").format(startDateTime));
      startDateTime = startDateTime.add(Duration(hours: 1));
    }

    return hours;
  }


  String addHalfHour(String time) {
    try {
      DateTime dateTime = DateFormat("HH:mm:ss").parse(time);
      DateTime fullDateTime = DateTime.now().copyWith(
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: dateTime.second,
      );

      DateTime newTime = fullDateTime.add(Duration(minutes: 30));

      return DateFormat("HH:mm:ss").format(newTime);
    } catch (e) {
      print("Error parsing time: $e");
      return time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.homescreen);
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              size: MediaQuery.of(context).size.height * 0.025,
            ),
          ),
        ),
        title: Text(
          "Book Appointment".tr,
          style:  Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,

      ),
      body: GetBuilder<CardController>(
        builder: (controller) {
          if (loaderController.loading.value) {
            return Center(
              child: CircularProgressIndicator(color: PrimaryColor),
            );
          }

          final doctor = controller.servicesList?.expand((category) => category.services ?? [])
              .firstWhere((service) => service.id == widget.doctorId, orElse: () => null);

          if (doctor == null) {
            return Center(child: Text("Doctor not found"));
          }

          final doctorDays = doctor.workingDays;
          final String? startTime = doctor.workingHours?.start;
          final String? endTime = doctor.workingHours?.end;

          if (startTime == null || endTime == null) {
            return Center(child: Text("No working hours available".tr));
          }

          List<String> availableHours = getAvailableHours(startTime, endTime);

          return ListView(
              children: [
                DoctorDetailsList(
                  maintext: doctor.serviceName ?? "No Name",
                  subtext: doctor.specialty ?? "No Description",
                  image:  "Assets/images/person.jpg",
                  firstmaintext: doctor.reviewRate  ?? "No Name",
                  secondmaintext: doctor.exYear  ?? "No Name",
                  thirdmaintext: doctor.appointmentsCount ?? "No Name",
                ),
                const SizedBox(height: 15),
                GestureDetector(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About".tr,
                              style:  Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              doctor.description ?? "No Description",
                              style:  Theme.of(context).textTheme.bodyLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextField(
                                controller: noteController,
                                decoration: InputDecoration(labelText: 'Note'.tr),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "Available Days".tr,
                                      style:  Theme.of(context).textTheme.headlineLarge,
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: doctorDays!.length,
                                      itemBuilder: (context, index) {
                                        final day = doctorDays[index];
                                        final correspondingDate = getDateForDay(day);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedDay = day;
                                                selectedDate = correspondingDate;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: selectedDay == day
                                                  ? PrimaryColor
                                                  : Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  day,
                                                  style: TextStyle(
                                                    color: selectedDay == day
                                                        ? Colors.white
                                                        : PrimaryColor,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  correspondingDate,
                                                  style: TextStyle(
                                                    color: selectedDay == day
                                                        ? Colors.white
                                                        : PrimaryColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Divider(
                                      color: Colors.black12,
                                      thickness: 1,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          "Available Hours".tr,
                                          style:  Theme.of(context).textTheme.headlineLarge,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: availableHours.length,
                                          itemBuilder: (context, index) {
                                            final hour = availableHours[index];
                                            return Padding(
                                              padding:
                                              const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    selectedTime = hour;
                                                    String endTime = addHalfHour(selectedTime!);
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: selectedTime == hour
                                                      ? PrimaryColor
                                                      : Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                                child: Text(
                                                  hour,
                                                  style: TextStyle(
                                                    color: selectedTime == hour
                                                        ? Colors.white
                                                        : PrimaryColor,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Obx(() {

                              return appointmencontroller.loaderController.loading.value

                                  ? SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              )
                                  : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (widget.appointmentId == null) {
                                          appointmencontroller.createAppointment(
                                            profileId: profcontroller.selectedCardId.value,
                                            note: noteController.text,
                                            start: "$selectedDate $selectedTime",
                                            end: addHalfHour("$selectedDate $selectedTime"),
                                            serviceProviderId: widget.doctorId,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: PrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text(
                                        widget.appointmentId == null ? 'Create Appointment'.tr : 'Update Appointment'.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),

                          ],
                        )
                    ))



              ]);
        },
      ),

    );
  }
}

