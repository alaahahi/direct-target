import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:direct_target/Screen/Profile/ProfileScreen.dart';
import 'package:direct_target/Screen/Schedule/ScheduleScreen.dart';
import 'package:get/get.dart';
import 'package:direct_target/Screen/Home/CardsScreen.dart';
import 'package:direct_target/Screen/Services/Servicescreen.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Controller/ThemeController.dart';
import 'package:direct_target/Widgets/ThemeToggleButton.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<IconData> icons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.servicestack,
    FontAwesomeIcons.clipboardCheck,
    FontAwesomeIcons.user,
  ];

  int page = 0;

  List<Widget> pages = [
    CardsLayout(),
    Servicescreen(),
    shedule_screen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() {
          String logoPath = themeController.isDarkMode.value
              ? "Assets/images/logo422.png"
              : "Assets/images/logo41.png";
          return Row(
            children: [
              SizedBox(
                width: 65.0,
                height: 47,
                child: Image.asset(
                  logoPath,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          );
        }),
        actions: [
          Obx(() {
            Color iconColor = themeController.isDarkMode.value
                ? LightGrey
                : PrimaryColor;
            return IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_on),
              color: iconColor,
            );
          }),
          ThemeToggleButton(),
        ],
      ),
      body: pages[page],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        iconSize: 20,
        activeIndex: page,
        height: 80,
        splashSpeedInMilliseconds: 300,
        gapLocation: GapLocation.none,
        activeColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : PrimaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        inactiveColor: Theme.of(context).brightness == Brightness.dark
            ?  BorderGrey
            :  TextGrey,
        onTap: (int tappedIndex) {
          setState(() {
            page = tappedIndex;
          });
        },
      ),
    );
  }
}
