import 'package:direct_target/Screen/Home/HomeScreenBody.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Controller/ThemeController.dart';
import 'package:direct_target/Widgets/ThemeToggleButton.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                width: 50.0,
                height: 31,
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
      body: HomeScreenBody()
    );
  }
}
