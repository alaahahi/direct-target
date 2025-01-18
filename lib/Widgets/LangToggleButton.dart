import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Controller/ThemeController.dart';
import 'package:get_storage/get_storage.dart';

class LangToggleButton extends StatelessWidget {
  const LangToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final GetStorage storage = GetStorage();

    return Obx(() {
      Color iconColor = themeController.isDarkMode.value
          ? LightGrey
          : PrimaryColor;

      return IconButton(
        onPressed: () {

          if (Get.locale == const Locale('en', 'US')) {
            Get.updateLocale(const Locale('ar', 'EG'));
            storage.write('language', 'ar');
          } else {
            Get.updateLocale(const Locale("en", "US"));
            storage.write('language', 'en');
          }
        },
        icon: Icon(
          Icons.language,
          color: iconColor,
        ),
      );
    });
  }
}
