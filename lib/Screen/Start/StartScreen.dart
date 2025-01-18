import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Screen/Auth/SignIn/SignInScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Widgets/ThemeToggleButton.dart';
import 'package:direct_target/Widgets/LangToggleButton.dart';
import 'package:direct_target/Controller/ThemeController.dart';
class Startscreen extends StatelessWidget {
  const Startscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    String logoPath = themeController.isDarkMode.value
        ? "Assets/images/logo1.png"
        : "Assets/images/logo2.png";
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Color Iconcolor = themeController.isDarkMode.value
        ? LightGrey
        : PrimaryColor;
    return Scaffold(

      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LangToggleButton(),

            ThemeToggleButton(),
          ],
        ),
      ),



      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            height: screenHeight * 0.3,
            width: screenHeight * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(logoPath),
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lets get Started!".tr,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Login to enjoy the features we've \nprovided, and stay healthy".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Theme.of(context).textTheme.bodyLarge?.color,

                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
              onPressed: () {
                Get.off(() => SignInScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Login".tr,
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
          const Spacer(),

          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: Homepage(),
                ),
              );
            },
            child: Text(
              "Sign in as a Visitor".tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );

  }
}
