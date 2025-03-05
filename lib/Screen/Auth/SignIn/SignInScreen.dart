import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Auth/SignIn/SignInScreenBody.dart';
import 'package:get/get.dart';
import '../../../Utils/AppStyle.dart';
import 'dart:ui' as ui;

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
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
          centerTitle: true,
          title: Text(
            "Login".tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          toolbarHeight: 110,
          elevation: 0,
        ),
        backgroundColor: PrimaryColor,
        body: SignInScreenBody(),
      ),
    );
  }
}
