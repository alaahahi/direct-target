import 'package:direct_target/Screen/Notification/NotificationBodyScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/AppStyle.dart';
import '../Profile/Terms/TermsBody.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
            'Notification'.tr,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NotificationBodyScreen(),
        ));
  }
}
