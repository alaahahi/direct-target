import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/DoctorList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../../Controller/AppointmentController.dart';
import '../../../Controller/CardServiceController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Controller/ProfileCardController.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {

  final int? appointmentId; // إذا كان الموعد موجودًا

  AppointmentScreen({ this.appointmentId});
  // DoctorDetails({required this.doctorId});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final CardServiceController controller = Get.put(CardServiceController());
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
      return time; // تجنب الكراش بإرجاع نفس القيمة عند الخطأ
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: Homepage()));
          },
          child: Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/icons/back1.png"),
                )),
          ),
        ),
        title: Text(
          "Edit Book Appointment".tr,
          style:  Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/icons/more.png"),
                  )),
            ),
          ),
        ],
      ),
      body: GetBuilder<AppointmentController>(
        builder: (controller) {
          if (loaderController.loading.value) {
            return Center(
              child: CircularProgressIndicator(color: PrimaryColor),
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
              const SizedBox(height: 10),
              doctorList(
                image: doctor.serviceProvider?.image ?? "Assets/icons/person.png",
                maintext: doctor.serviceProvider!.serviceName!.tr,
                subtext: doctor.serviceProvider!.serviceName!.tr,

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
              const SizedBox(height: 10),
              Obx(() {
                return appointmencontroller.loaderController.loading.value
                    ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                )
                    : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.appointmentId != null && selectedDate != null && selectedTime != null) {
                        String formattedStart = "$selectedDate $selectedTime";
                        String formattedEnd = addHalfHour(formattedStart);

                        print("Formatted Start: $formattedStart");  // Debugging
                        print("Formatted End: $formattedEnd");      // Debugging

                        appointmencontroller.updateAppointment(
                          note: noteController.text,
                          start: formattedStart,
                          end: formattedEnd,
                          appointmentId: widget.appointmentId!,
                        );
                      } else {
                        Get.snackbar("Error", "Please select a date and time");
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                     'Update Appointmennt'.tr,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }),

              // Text("Working Days: ${doctorDays?.join(", ")}"),
              // Text("Available Hours: ${availableHours.join(", ")}"),
            ],
          );
        },
      ),

    );
  }
}

