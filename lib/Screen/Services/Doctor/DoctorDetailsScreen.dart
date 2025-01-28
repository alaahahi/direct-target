import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Widgets/DoctorList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../../Controller/AppointmentController.dart';
import '../../../Controller/CardServiceController.dart';
import '../../../Controller/ProfileCardController.dart';
import 'SearchScreen.dart';
import 'package:intl/intl.dart';
class DoctorDetails extends StatefulWidget {
  final int doctorId;

  DoctorDetails({required this.doctorId});

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  final CardServiceController controller = Get.put(CardServiceController());
  final AppointmentController appointmencontroller = Get.put(AppointmentController());
  final TextEditingController noteController = TextEditingController();
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final ProfileCardController profcontroller = Get.put(ProfileCardController());
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
    DateTime timeDateTime = parseTime(time);
    DateTime newTime = timeDateTime.add(Duration(minutes: 30));
    return DateFormat("HH:mm:ss").format(newTime);
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
                type: PageTransitionType.fade,
                child: doctor_search(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back,
            size: 24,
            color: PrimaryColor,
          ),
        ),
        title: Text(
          "Doctor Details".tr,
          style: GoogleFonts.poppins(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final doctor = controller.cardServices.firstWhere(
              (service) => service.id == widget.doctorId,
          orElse: () => null!,
        );
        final doctorDays=doctor.workingDays;
        final String startTime = doctor.workingHours.start;
        final String endTime = doctor.workingHours.end;
        List<String> availableHours = getAvailableHours(startTime, endTime);
        if (doctor == null) {
          return Center(child: Text("Doctor not found"));
        }

        return ListView(
          children: [
            const SizedBox(height: 5),
            doctorList(

              image: doctor.image ?? "Assets/icons/male-doctor.png",
              maintext: doctor.serviceName.tr,

              subtext: doctor.serviceName.tr,
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
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doctor.description.tr,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 14,
                      ),
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
                decoration: InputDecoration(labelText: 'Note'),
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
        itemCount: doctorDays.length,
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
        backgroundColor: selectedDay == day ? PrimaryColor : Colors.white,
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(
        day,
        style: TextStyle(
        color: selectedDay == day ? Colors.white : PrimaryColor,
        ),
        ),
        SizedBox(height: 4),
        Text(
        correspondingDate,
        style: TextStyle(
        color: selectedDay == day ? Colors.white : PrimaryColor,
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTime = hour;
                                    String endTime = addHalfHour(selectedTime!);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedTime == hour ? PrimaryColor : Colors.white,
                                ),
                                child: Text(
                                  hour,
                                  style: TextStyle(
                                    color: selectedTime == hour ? Colors.white : PrimaryColor,
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
              return appointmencontroller.isLoading.value
                  ? SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              )
                  : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                                    onPressed: () {
                    appointmencontroller.createAppointment(
                      profcontroller.selectedCardId.value,
                      noteController.text,
                      startController.text ="$selectedDate $selectedTime",
                      endController.text = "$selectedDate $endTime",

                    );
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                                    child: Text('Create Appointment',
                                      style: TextStyle(
                                        color:  Colors.white ,
                                      ),),
                                  ),
                  );
            }),

          ],
        );
      }),
    );
  }
}

