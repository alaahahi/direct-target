
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Service/CardServices.dart';
import '../Service/SettingsServices.dart';
import '../Utils/Constant.dart';
import 'AllSettingController.dart';
import 'CardController.dart';


class LanguageController extends GetxController {
  SingingCharacter? character;
  final AllSettingController _appController = Get.put(AllSettingController(SettingsServices()));

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
      Get.put(CardServices());
      Get.find<CardController>().getCards();
      Get.find<CardController>().getCardCategoryServices(_appController.appCardValue.value);
      Get.find<CardController>().getPopularService();
      update();
    });
  }


}
