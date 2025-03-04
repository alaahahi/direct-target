import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../../Controller/TokenController.dart';
import 'HomeContentScreenBody.dart';


class HomeContentScreen extends StatelessWidget {
  HomeContentScreen({super.key});

  final tokenController = Get.find<TokenController>();


  @override
  Widget build(BuildContext context) {
    return  HomeContentScreenBody();

  }
}
