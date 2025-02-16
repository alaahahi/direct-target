
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/Constant.dart';

class LanguageController extends GetxController {
  SingingCharacter? character;

  @override
  void onInit() {
    super.onInit();
    character = Get.locale?.languageCode == 'ar'
        ? SingingCharacter.arabic
        : SingingCharacter.english;
  }

  void setCharacter(SingingCharacter? value) {
    character = value;
    if (value == SingingCharacter.english) {
      Get.updateLocale(const Locale('en'));
    } else if (value == SingingCharacter.arabic) {
      Get.updateLocale(const Locale('ar'));
    }

    update();
  }
}
