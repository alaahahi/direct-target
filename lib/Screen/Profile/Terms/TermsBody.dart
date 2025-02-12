import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/AllSettingController.dart';
import '../../../Service/SettingsServices.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class TermsBody extends StatefulWidget {
  const TermsBody({super.key});

  @override
  State<TermsBody> createState() => _TermsBodyState();
}

class _TermsBodyState extends State<TermsBody> {
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



