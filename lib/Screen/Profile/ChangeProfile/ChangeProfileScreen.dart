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
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              color: TextGrey,
            ),
            title: Text('Change Password'.tr),
            centerTitle: true,
            titleTextStyle: AppBarTextStyle),
        body: const ChangePasswordBody());
  }
}
