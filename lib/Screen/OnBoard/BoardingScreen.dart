import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Start/StartScreen.dart';
import 'package:direct_target/Screen/OnBoard/FirstBoardScreen.dart';
import 'package:direct_target/Screen/OnBoard/SecondBoardScreen.dart';
import 'package:direct_target/Screen/OnBoard/ThirdBoardScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';

import 'package:direct_target/Controller/TokenController.dart';

import '../../Routes/Routes.dart'; // استدعاء ملف التوكين

class on_boarding extends StatefulWidget {
  const on_boarding({super.key});

  @override
  State<on_boarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<on_boarding> {
  final TokenController tokenController = Get.put(TokenController());
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (tokenController.isTokenValid.value) {
        Get.offAllNamed(AppRoutes.homescreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              OnBoard1(),
              OnBoard2(),
              OnBoard3(),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    "Skip".tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: TextGrey,
                        ),
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
                    dotColor: Color.fromARGB(255, 232, 209, 250),
                    activeDotColor: PrimaryColor,
                  ),
                ),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Get.offAll(
                              () => StartScreen()); // الانتقال إلى StartScreen
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.25,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: LightGrey),
                                ),
                                SizedBox(width: 4),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
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
                          width: MediaQuery.of(context).size.width * 0.25,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: LightGrey),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.height *
                                        0.04,
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
