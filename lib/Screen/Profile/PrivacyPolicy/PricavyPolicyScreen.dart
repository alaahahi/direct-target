import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/AppStyle.dart';
import 'PrivacyBody.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              color: TextGrey,
            ),
            title: Text('Privacy Policy'),
            centerTitle: true,
            titleTextStyle: AppBarTextStyle),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrivacyBody(),
        ));
  }
}
