import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/AllSettingController.dart';
import '../../../Service/SettingsServices.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class NotificationBodyScreen extends StatefulWidget {
  const NotificationBodyScreen({super.key});

  @override
  State<NotificationBodyScreen> createState() => _NotificationBodyScreenState();
}

class _NotificationBodyScreenState extends State<NotificationBodyScreen> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HtmlWidget(
            _controller.termsCondition.toString(),
          ),
        ],
      ),
    );
  }
}



