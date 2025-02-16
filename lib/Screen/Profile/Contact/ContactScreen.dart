import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/AppStyle.dart';
import '../PrivacyPolicy/PrivacyBody.dart';
import 'ContactBodyScreen.dart';



class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.arrow_back_ios, // أيقونة الرجوع
                  color: Theme.of(context).textTheme.bodyMedium?.color, // يمكنك تغيير اللون
                  size: MediaQuery.of(context).size.height * 0.025, // التحكم في الحجم
                ),
              ),

              onPressed: () => Get.back(),
            ),
            title: Text('App Information'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),),
            centerTitle: true,
            titleTextStyle: AppBarTextStyle),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ContactBodyScreen(),
        ));
  }
}
