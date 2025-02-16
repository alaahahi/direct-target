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
              icon: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  size: MediaQuery.of(context).size.height * 0.025,
                ),
              ),

              onPressed: () => Get.back(),
            ),
            title: Text('Privacy Policy'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),),
            centerTitle: true,
            titleTextStyle: AppBarTextStyle),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrivacyBody(),
        ));
  }
}
