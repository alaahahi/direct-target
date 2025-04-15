import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Controller/AppointmentController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Controller/ProfileCardController.dart';
import 'package:intl/intl.dart';
import '../../../Routes/Routes.dart';
import '../../../Widgets/AuthFormFiled.dart';
import '../../../Widgets/DoctorDetailsList.dart';
import 'dart:ui' as ui;
class PopularDoctorDetailsScreen extends StatefulWidget {
  final int doctorId;
  final int? appointmentId;

  PopularDoctorDetailsScreen({required this.doctorId, this.appointmentId});
  @override
  _PopularDoctorDetailsScreenState createState() => _PopularDoctorDetailsScreenState();
}

class _PopularDoctorDetailsScreenState extends State<PopularDoctorDetailsScreen> {

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
  final _cardNumberController = TextEditingController();

  String? userPhone;
  bool? isAdmin;
  bool _hasError = false;
  String _errorMessage = '';
  final _phoneController = TextEditingController();
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


  String addHalfHour(String dateTimeStr) {
    print("Parsing Time: $dateTimeStr");
    try {
      DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeStr);
      DateTime newDateTime = dateTime.add(Duration(minutes: 30));
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(newDateTime);
    } catch (e) {
      print("Error parsing dateTime: $e");
      return dateTimeStr;
    }
  }
  final Map<String, String> weekDaysArabic = {
    "Sunday": "الأحد",
    "Monday": "الإثنين",
    "Tuesday": "الثلاثاء",
    "Wednesday": "الأربعاء",
    "Thursday": "الخميس",
    "Friday": "الجمعة",
    "Saturday": "السبت",
  };
  @override
  void initState() {
    super.initState();

    GetStorage.init().then((_) {
      final storage = GetStorage();
      setState(() {
        userPhone = storage.read('userPhone') ?? '';
        isAdmin = storage.read('isAdmin') ?? false;
        print("isAdmin: $isAdmin");
      });
    });

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
          "Book Appointment".tr,
          style: Theme.of(context).textTheme.headlineLarge,
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

          final doctor = controller.allServicesList
              ?.firstWhere((service) => service.id == widget.doctorId);

          if (doctor == null) {
            return Center(child: Text("Doctor not found"));
          }
          print("Doctor details: ${doctor.serviceName}");

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
                  image:  doctor.image ??"Assets/images/person.jpg",
                  firstmaintext: doctor.reviewRate  ?? "No Name",
                  secondmaintext: doctor.exYear  ?? 0,
                  thirdmaintext: doctor.appointmentsPerDay ?? 1,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Directionality(
                              textDirection: ui.TextDirection.ltr,
                              child: AuthFormField(
                                controller: _phoneController,
                                hint: 'Phone Number'.tr,
                                keyboardType: TextInputType.number,

                                onChange: (value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    setState(() {
                                      _hasError = true;
                                      _errorMessage = "يجب إدخال رقم الهاتف".tr;
                                    });
                                    return '';
                                  } else if (value.length != 10) {
                                    setState(() {
                                      _hasError = true;
                                      _errorMessage = "يجب أن يكون الرقم مكونًا من 10 أرقام".tr;
                                    });
                                    return '';
                                  }
                                  setState(() {
                                    _hasError = false;
                                    _errorMessage = '';
                                  });
                                  return null;
                                },
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          'Assets/images/iraq.png',
                                          width: 28,
                                          height: 20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '+964',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            if (_hasError)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    _errorMessage,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                            if (isAdmin != null && isAdmin!)
                              AuthFormField(
                                controller: _cardNumberController,
                                keyboardType: TextInputType.number,
                                hint: 'Card Number'.tr,
                                onChange: (value) {},
                              ),
                            SizedBox(height: 20),
                            Text(
                              "About".tr,
                              style:  Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              doctor.description ?? "No Description",
                              style:  Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color:  Colors.grey,
                              ),
                            ),
                            doctor.showOnApp == true ?
                            Column(
                              children: [
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
                                            final day = doctorDays[index].trim();
                                            final translatedDay = Get.locale?.languageCode == 'ar'
                                                ? weekDaysArabic[day] ?? day
                                                : day;
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
                                                      translatedDay,
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
                                            if (noteController.text.isEmpty) {
                                              Get.snackbar('Error', 'Please enter a note', backgroundColor: Colors.red, colorText: Colors.white);
                                              return;
                                            }

                                            if (selectedDay == null) {
                                              Get.snackbar('Error', 'Please select a day', backgroundColor: Colors.red, colorText: Colors.white);
                                              return;
                                            }

                                            if (selectedTime == null) {
                                              Get.snackbar('Error', 'Please select a time', backgroundColor: Colors.red, colorText: Colors.white);
                                              return;
                                            }

                                            if (widget.appointmentId == null) {
                                              appointmencontroller.createAppointment(
                                                profileId: profcontroller.selectedCardId.value,
                                                note: noteController.text,
                                                start: "$selectedDate $selectedTime",
                                                end: addHalfHour("$selectedDate $selectedTime"),
                                                serviceProviderId: widget.doctorId,
                                                phone:_phoneController.text,
                                                cardNumber: _cardNumberController.text
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
                            ) : const SizedBox()

                          ],
                        )
                    ))



              ]);
        },
      ),

    );
  }
}

