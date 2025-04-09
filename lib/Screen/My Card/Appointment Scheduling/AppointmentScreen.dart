import 'package:flutter/material.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../../Controller/AppointmentController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Controller/ProfileCardController.dart';
import 'package:intl/intl.dart';

import '../../../Widgets/DoctorDetailsList.dart';

class AppointmentScreen extends StatefulWidget {

  final int? appointmentId;

  AppointmentScreen({ this.appointmentId});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
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
      DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
      DateTime newTime = dateTime.add(Duration(minutes: 30));
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(newTime);
    } catch (e) {
      print("Error parsing time: $e");
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
          "Edit Book Appointment".tr,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: GetBuilder<AppointmentController>(
        builder: (controller) {
          if (loaderController.loading.value) {
            return SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: CircularProgressIndicator(color: PrimaryColor),
              ),
            );
          }

          final doctor = controller.appointments
              .firstWhere((service) => service.id == widget.appointmentId);

          final doctorDays = doctor.serviceProvider?.workingDays;
          final String? startTime = doctor.serviceProvider?.workingHours?.start;
          final String? endTime = doctor.serviceProvider?.workingHours?.end;

          if (startTime == null || endTime == null) {
            return Center(child: Text("No working hours available".tr));
          }

          List<String> availableHours = getAvailableHours(startTime, endTime);

          return ListView(
            children: [
              DoctorDetailsList(
                maintext:  doctor.serviceProvider?.serviceName ?? "No Name",
                subtext:  doctor.serviceProvider?.specialty ?? "No Description",
                image:  doctor.serviceProvider?.image ?? "Assets/images/person.jpg",
                firstmaintext:  doctor.serviceProvider?.reviewRate  ?? "No Name",
                secondmaintext:  doctor.serviceProvider!.exYear!,
                thirdmaintext:  doctor.serviceProvider!.appointmentsPerDay! ,
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
                        style:  Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        doctor.serviceProvider!.description!.tr,
                        style:  Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                  children: [
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
                      children: [
                        SizedBox(height: 10),
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
              const SizedBox(height: 20),
              Obx(() {
                return appointmencontroller.loaderController.loading.value
                    ? Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.appointmentId != null && selectedDate != null && selectedTime != null) {
                        String formattedStart = "$selectedDate $selectedTime";
                        String formattedEnd = addHalfHour(formattedStart);
                        appointmencontroller.updateAppointment({
                          "note": noteController.text,
                          "start": formattedStart,
                          "end": formattedEnd,
                          "appointmentId": widget.appointmentId!,
                        });
                      } else {
                        Get.snackbar("Error", "Please select a date and time".tr);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Update Appointment'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              })

            ],
          );
        },
      ),

    );
  }
}

