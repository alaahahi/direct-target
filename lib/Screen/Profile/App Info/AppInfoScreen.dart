import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/AppStyle.dart';
import 'AppInfoBodyScreen.dart';


class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
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
            'App Information'.tr,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppInfoBodyScreen(),
        ));
  }
}
