import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../Controller/TokenController.dart';
import 'DashboardScreenBody.dart';


class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final tokenController = Get.find<TokenController>();


  @override
  Widget build(BuildContext context) {
    return  DashboardScreenBody();

  }
}
