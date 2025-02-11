import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/AllSettingController.dart';
import '../../../Service/SettingsServices.dart';
import '../../../Utils/AppStyle.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class PrivacyBody extends StatefulWidget {
  const PrivacyBody({super.key});

  @override
  State<PrivacyBody> createState() => _PrivacyBodyState();
}

class _PrivacyBodyState extends State<PrivacyBody> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          HtmlWidget(
            _controller.privacyPolicy.toString(),
          ),
        ],
      ),
    );
  }
}


