import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/AppStyle.dart';
import 'TermsBody.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
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
            title: Text('Privacy Policy'.tr),
            centerTitle: true,
            titleTextStyle: AppBarTextStyle),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TermsBody(),
        ));
  }
}
