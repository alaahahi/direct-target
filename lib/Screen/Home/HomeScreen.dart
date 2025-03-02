import 'package:direct_target/Screen/Home/HomeScreenBody.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Controller/ThemeController.dart';
import 'package:direct_target/Widgets/ThemeToggleButton.dart';

import '../../Controller/TokenController.dart';
import '../../Routes/Routes.dart';
import '../Auth/SignIn/SignInScreen.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final TokenController tokenController = Get.put(TokenController());
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
              onPressed: () {
                Get.toNamed(AppRoutes.notification);
              },
              icon: Icon(Icons.notifications_on),
              color: iconColor,
            );
          }),
          ThemeToggleButton(),


          Obx(() {
            if (tokenController.token.value.isEmpty) {
              return IconButton(
                onPressed: () async {
                  await Get.to(() => SignInScreen());
                  if (tokenController.token.value.isNotEmpty) {
                    Get.offAll(() => Homepage());
                  }
                  print("Token after login: ${tokenController.token.value}");
                },
                icon: Icon(Icons.login),
                color: themeController.isDarkMode.value ? LightGrey : PrimaryColor,
              );
            }
            return SizedBox.shrink();
          })
        ],
      ),
      body: HomeScreenBody()
    );
  }
}
