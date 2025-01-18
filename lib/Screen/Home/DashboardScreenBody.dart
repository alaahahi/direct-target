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


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CarouselSlider(
          items: [
            'Assets/images/4.jpg',
            'Assets/images/5.jpg',
          ].map((item) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Servicescreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              child: Image.asset(item, fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'News for up-to-the-minute news, breaking news, video, audio and feature stories.'.tr,

                            maxLines: 2,

                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 250,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 4 / 3,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
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
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRequestScreen(),
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
            ),


          ],
        ),

        const SizedBox(
          height: 20,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Top Doctor".tr,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyLarge?.color,
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
                  color: Theme.of(context).textTheme.bodyLarge?.color,
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
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: DoctorDetails()));
                },
                child: list_doctor1(
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
                child: list_doctor1(
                    distance: "800m Away",
                    image: "Assets/icons/black-doctor.png",
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
                child: list_doctor1(
                    distance: "800m Away",
                    image: "Assets/icons/doctor2.png",
                    maintext: "Dr. Marcus Horizon".tr,
                    numRating: "4.7",
                    subtext: "Chardiologist".tr),
              ),
            ],
          ),
        ),
      ]),
    );

  }
}
