import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Screen/Start/StartScreen.dart';
import 'package:direct_target/Screen/OnBoard/FirstBoardScreen.dart';
import 'package:direct_target/Screen/OnBoard/SecondBoardScreen.dart';
import 'package:direct_target/Screen/OnBoard/ThirdBoardScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';

class on_boarding extends StatefulWidget {
  const on_boarding({super.key});

  @override
  State<on_boarding> createState() => _on_boardingState();
}

class _on_boardingState extends State<on_boarding> {
  PageController _controller = PageController();
  bool onLastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastpage = (index == 2);
              });
            },
            children: [
              OnBoard1(),
              OnBoard2(),
              OnBoard3(),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    "Skip".tr,
                    style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: SlideEffect(
                    spacing: 4.0,
                    radius: 4.0,
                    dotWidth: 14.0,
                    dotHeight: 7.0,
                    strokeWidth: 1.5,
                    dotColor: Color(0xFFD1FAFA),
                    activeDotColor: PrimaryColor,
                  ),
                ),
                onLastpage
                    ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: Startscreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Done".tr,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height *
                                0.04,
                            width: MediaQuery.of(context).size.width *
                                0.04,
                            child: Image.asset("Assets/icons/check.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next".tr,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.06,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.height * 0.04,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

