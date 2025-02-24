import 'package:direct_target/Screen/Home/AllCardScreenBody.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';

import '../../Utils/AppStyle.dart';


class AllCardScreen extends StatefulWidget {
  const AllCardScreen({super.key});

  @override
  State<AllCardScreen> createState() => _AllCardScreenState();
}

class _AllCardScreenState extends State<AllCardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AllCardBodyScreen()

    );
  }
}


