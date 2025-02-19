import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/AllSettingController.dart';
import '../../../Service/SettingsServices.dart';
class AppInfoBodyScreen extends StatefulWidget {
  const AppInfoBodyScreen({super.key});

  @override
  State<AppInfoBodyScreen> createState() => __AppInfoBodyScreenState();
}

class __AppInfoBodyScreenState extends State<AppInfoBodyScreen> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              _controller.appVersion.toString(),
              style: TextStyle(
                fontSize: 20
              ),
            ),
            Text(
              _controller.appName.toString(),
            ),

          ],
        ),
      ),
    );
  }
}


