import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Screen/Profile/ChangeProfile/ChangeProfileBody.dart';

import '../../../Utils/AppStyle.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                size: MediaQuery.of(context).size.height * 0.025,
              ),
            ),

            onPressed: () => Get.back(),
          ),
          title: Text(
            'Change Profile'.tr,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 100,
        ),
        body: const ChangeProfileBody());
  }
}
