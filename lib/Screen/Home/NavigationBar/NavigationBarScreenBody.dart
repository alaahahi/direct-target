import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:direct_target/Screen/Profile/ProfileScreen.dart';

import 'package:get/get.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Controller/ThemeController.dart';

import '../../My Card/AllCardScreen.dart';
import '../HomeScreen.dart';


class NavigationBarScreenBody extends StatefulWidget {
  @override
  State<NavigationBarScreenBody> createState() => _NavigationBarScreenBodyState();
}

class _NavigationBarScreenBodyState extends State<NavigationBarScreenBody> {
  List<IconData> icons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.vcard,

    FontAwesomeIcons.user,
  ];

  int page = 0;

  List<Widget> pages = [
    HomeScreen(),
    AllCardScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
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
