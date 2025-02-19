
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Service/CardServices.dart';
import '../Utils/Constant.dart';
import 'CardController.dart';
import 'CardServiceController.dart';

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

    print("Updated Language: ${Get.locale?.languageCode}");

    update();

    Future.delayed(Duration(milliseconds: 300), () async {
      final cardService = Get.find<CardServices>();
       Get.find<CardController>().getCards();
       Get.find<CardServiceController>().fetchCardServices(1);
       Get.find<CardController>().getPopularService();

      update();
    });
  }

}
