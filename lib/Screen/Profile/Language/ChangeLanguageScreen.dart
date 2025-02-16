import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Screen/Profile/Language/CahngeLanguageBody.dart';

import '../../../Utils/AppStyle.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  size: MediaQuery.of(context).size.height * 0.025,
                ),
              ),
              onPressed: () => Get.back(),
              color: TextGrey,
            ),
            title: Text('Change Language'.tr),
            centerTitle: true,
            titleTextStyle: AppBarTextStyle),
        body: ChangeLanguageBody());
  }
}
