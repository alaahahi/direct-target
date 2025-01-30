import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Screen/Services/Doctor/SearchScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/FindDoctorScreen.dart';
import 'package:direct_target/Widgets/DoctorListHome.dart';
import 'package:direct_target/Widgets/IconsList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:direct_target/Screen/Services/ServiceScreen.dart';
import 'package:direct_target/Screen/RequestCard/RequestScreen.dart';

import '../../Controller/CardServiceController.dart';
import '../../Controller/LoaderController.dart';
import '../../Controller/TokenController.dart';


class DashboardScreenBody extends StatelessWidget {
  DashboardScreenBody({super.key});
   final tokenController = Get.put(TokenController());
  LoaderController loaderController = Get.put(LoaderController());
   @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(),
            child: TextField(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: find_doctor()));
              },
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.none,
              autofocus: false,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusColor: Colors.black26,
                fillColor: Color.fromARGB(255, 247, 247, 247),
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    height: 10,
                    width: 10,
                    child: Image.asset(
                      "Assets/icons/search.png",
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                prefixIconColor:PrimaryColor,
                label: Text("Search doctor, drugs, articles...".tr),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => doctor_search()),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              'Assets/images/4.jpg',
              width: MediaQuery.of(context).size.width,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListIcons(icon: Icons.medical_services_outlined, text: "Doctor".tr, color: PrimaryColor),
            ListIcons(icon: Icons.local_pharmacy, text: "Pharmacy".tr, color: PrimaryColor),
            ListIcons(icon: Icons.local_hospital, text: "Hospital".tr, color: PrimaryColor),
            ListIcons(icon: Icons.local_taxi, text: "Ambulance".tr, color: PrimaryColor),
          ],
        ),

        const SizedBox(
          height: 20,
        ),

        Obx(() {
          return tokenController.isTokenValid.value
              ? Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestScreen(),
                  ),
                );
                            },
                            style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                            ),
                            child: Text(
                "Request Card".tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: LightGrey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
                            ),
                          ),
              )
              : SizedBox();
        }),


        const SizedBox(
          height: 20,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Join Now".tr,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: doctor_search()));
              },
              child: Text(
                "See all".tr,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 220,
          width: 400,
          child:GetBuilder<CardServiceController>(
            builder: (controller) {
              if (loaderController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(color: PrimaryColor),
                );
              }

              if (controller.allServiceList!.isEmpty) {
                return Center(
                  child: Text("No data available".tr,
                  style: TextStyle( color: Theme.of(context).textTheme.bodyMedium?.color,),),
                );
              }

              return ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: controller.allServiceList!.map((service) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: DoctorDetails(doctorId: service.id!),
                        ),
                      );
                    },
                    child: list_doctor1(
                      distance: "800m Away",
                      image: service.image != null
                          ? service.image!
                          : "Assets/icons/male-doctor.png",
                      maintext: service.serviceName!.tr,
                      numRating: "4.7",
                      subtext: service.serviceName!.tr,
                    ),
                  );
                }).toList(),
              );
            },
          )
        )
      ]),
    );

  }
}
