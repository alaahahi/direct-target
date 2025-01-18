import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ScheduleCard.dart';
import 'package:get/get.dart';
class shedule_tab1 extends StatelessWidget {
  const shedule_tab1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 30),

                shedule_card(
                  confirmation: "Confirmed".tr,
                  mainText: "Dr. Marcus Horizon".tr,
                  subText: "Cardiologist".tr,
                  date: "26/06/2022",
                  time: "10:30 AM",
                  image: "Assets/icons/male-doctor.png",
                ),
                const SizedBox(height: 20),
                shedule_card(
                  confirmation: "Confirmed".tr,
                  mainText: "Dr. Marcus Horizon".tr,
                  subText: "Cardiologist".tr,
                  date: "26/06/2022",
                  time: "2:00 PM",
                  image: "Assets/icons/female-doctor2.png",
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
