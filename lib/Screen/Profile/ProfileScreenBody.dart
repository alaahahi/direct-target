

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Widgets/ProfileList.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';

class ProfileScreenBody extends StatelessWidget {
  ProfileScreenBody({super.key});
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Stack(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage("Assets/icons/avatar.png"),
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.white),
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("Assets/icons/camra.png"))),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Amelia Renata".tr,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.2500,
                  child: Column(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.0400,
                      width: MediaQuery.of(context).size.width * 0.1500,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/icons/callories.png"),
                            filterQuality: FilterQuality.high),
                      ),
                    ),
                    Text(
                      "Calories".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 245, 243, 243)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "103lbs".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    )
                  ]),
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.white,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.2500,
                  child: Column(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.0400,
                      width: MediaQuery.of(context).size.width * 0.1500,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/icons/weight.png"),
                            filterQuality: FilterQuality.high),
                      ),
                    ),
                    Text(
                      "Weight".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 245, 243, 243)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "756cal".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    )
                  ]),
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.white,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.2500,
                  child: Column(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.0400,
                      width: MediaQuery.of(context).size.width * 0.1500,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/icons/heart.png"),
                            filterQuality: FilterQuality.high),
                      ),
                    ),
                    Text(
                      "Heart rate".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 245, 243, 243)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "215bpm",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    )
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 550,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? DarkBGColor
                  : LightGrey,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50),
                ProfileList(
                  icon: Icons.favorite,
                  title: "My Saved".tr,
                  iconColor: Colors.pink,
                  textColor: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                ProfileList(
                  icon: Icons.calendar_today,
                  title: "Appointment".tr,
                  iconColor: PrimaryColor,
                  textColor: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                ProfileList(
                  icon: Icons.chat,
                  title: "FAQs".tr,
                  iconColor: Colors.green,
                  textColor: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                ProfileList(
                  icon: Icons.payment,
                  title: "Payment Method".tr,
                  iconColor: Colors.purple,
                  textColor: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                ProfileList(
                  icon: Icons.logout,
                  title: "Log out".tr,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
