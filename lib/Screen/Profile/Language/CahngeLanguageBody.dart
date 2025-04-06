
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/LanguageController.dart';
import '../../../Utils/Constant.dart';

class ChangeLanguageBody extends StatelessWidget {
  ChangeLanguageBody({super.key});
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<LanguageController>(
        builder: (controller) => Column(
          children: [
            ListTile(
              title: const Text('English'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.english,
                groupValue: controller.character,
                onChanged: (SingingCharacter? value) {
                  controller.setCharacter(SingingCharacter.english);
                },
              ),
            ),
            ListTile(
              title: const Text('عربي'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.arabic,
                groupValue: controller.character,
                onChanged: (SingingCharacter? value) {
                  controller.setCharacter(SingingCharacter.arabic);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

