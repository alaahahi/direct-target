import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:get/get.dart';

import '../../../Controller/CardServiceController.dart';
import '../../../Widgets/doctorList.dart';

class doctor_search extends StatelessWidget {
  doctor_search({super.key});
  final CardServiceController controller = Get.put(CardServiceController());
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
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.cardServices.isEmpty) {
            return Center(
                child: Text("No services available"));
          }
          return ListView.builder(
              itemCount: controller.cardServices.length,
              itemBuilder: (context, index) {
                final service = controller.cardServices[index];
                return SafeArea(
                    child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: DoctorDetails(doctorId: service.id)));
                      },
                      child: doctorList(
                          maintext: service.serviceName.tr,
                          subtext: service.serviceName.tr,
                        image: service.image != null
                            ? service.image!
                            : "Assets/icons/male-doctor.png",
                      ),
                    ),
                  ],
                ));
              });
        }));
  }
}
