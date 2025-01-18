import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Controller/ThemeController.dart';
import 'package:direct_target/Utils/AppStyle.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      Color iconColor = themeController.isDarkMode.value
          ? LightGrey
          : PrimaryColor;

      return IconButton(
        onPressed: themeController.toggleTheme,
        icon: Icon(
          themeController.isDarkMode.value
              ? Icons.light_mode
              : Icons.dark_mode,
          color: iconColor,
        ),
      );
    });
  }
}
