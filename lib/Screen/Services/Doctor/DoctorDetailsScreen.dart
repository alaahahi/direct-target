import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Screen/Appointment/AppointmentScreen.dart';
import 'package:direct_target/Widgets/DateSelect.dart';
import 'package:direct_target/Widgets/DoctorList.dart';
import 'package:direct_target/Widgets/TimeSelect.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';

class DoctorDetails extends StatefulWidget {
  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool showExtendedText = false;

  void toggleTextVisibility() {
    setState(() {
      showExtendedText = !showExtendedText;
    });
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
                child: Homepage(),
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
          "Top Doctors".tr,
          style: GoogleFonts.poppins(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  doctorList(
                    distance: "800m away",
                    image: "Assets/icons/male-doctor.png",
                    maintext: "Dr. Marcus Horizon".tr,
                    numRating: "4.7",
                    subtext: "Cardiologist".tr,
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: toggleTextVisibility,
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
                            showExtendedText
                                ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod elipss this is just a dummy text with some free lines do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam consectetur adipiscing elit. Sed euismod ...".tr
                                : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod elipss this is just a dummy text with some free ... ".tr,
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            showExtendedText ? "Read less".tr : "Read more".tr,
                            style: TextStyle(color: PrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          date_Select(date: "21", maintext: "Mon"),
                          date_Select(date: "22", maintext: "Tue"),
                          date_Select(date: "23", maintext: "Wed"),
                          date_Select(date: "24", maintext: "Thu"),
                          date_Select(date: "25", maintext: "Fri"),
                          date_Select(date: "26", maintext: "Sat"),
                          date_Select(date: "27", maintext: "Sun"),
                          date_Select(date: "28", maintext: "Mon"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            time_select(mainText: "09:00 AM"),
                            time_select(mainText: "01:00 PM"),
                            time_select(mainText: "04:00 PM"),
                            time_select(mainText: "07:00 PM"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            time_select(mainText: "10:00 AM"),
                            time_select(mainText: "02:00 PM"),
                            time_select(mainText: "07:00 PM"),
                            time_select(mainText: "09:00 PM"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            time_select(mainText: "11:00 AM"),
                            time_select(mainText: "03:00 PM"),
                            time_select(mainText: "08:00 PM"),
                            time_select(mainText: "10:00 AM"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: appointment(),
                  ),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: PrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Book Appointment".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
