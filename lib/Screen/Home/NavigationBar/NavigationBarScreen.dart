import 'package:direct_target/Screen/Home/NavigationBar/NavigationBarScreenBody.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Controller/ThemeController.dart';
import 'package:direct_target/Widgets/ThemeToggleButton.dart';

import '../../../Controller/TokenController.dart';
import '../../../Routes/Routes.dart';
import '../../Auth/SignIn/SignInScreen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
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
                GestureDetector(
                onTap: () {
              print("Logo clicked!");
              Navigator.pushNamed(context, AppRoutes.homescreen);
            },
            child: SizedBox(
            width: 50.0,
            height: 37,
            child: Image.asset(
            logoPath,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            ),
            ),
            )



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
                      Get.offAll(() => NavigationBarScreen());
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
        body: NavigationBarScreenBody()
    );
  }
}

