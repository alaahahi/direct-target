import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:get/get.dart';

import '../../../Widgets/doctorList.dart';
class doctor_search extends StatelessWidget {
  const doctor_search({super.key});

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
          "Top Doctors".tr,
          style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 18),
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
      body: SafeArea(
          child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: DoctorDetails()));
            },
            child: doctorList(
                distance: "800m Away",
                image: "Assets/icons/docto3.png",
                maintext: "Dr. Marcus Horizon".tr,
                numRating: "4.7",
                subtext: "Chardiologist".tr),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: DoctorDetails()));
            },
            child: doctorList(
                distance: "800m Away",
                image: "Assets/icons/male-doctor.png",
                maintext: "Dr. Marcus Horizon".tr,
                numRating: "4.7",
                subtext: "Chardiologist".tr),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: DoctorDetails()));
            },
            child: doctorList(
                distance: "800m Away",
                image: "Assets/icons/female-doctor2.png",
                maintext: "Dr. Marcus Horizon".tr,
                numRating: "4.7",
                subtext: "Chardiologist".tr),
          ),
        ],
      )),
    );
  }
}
