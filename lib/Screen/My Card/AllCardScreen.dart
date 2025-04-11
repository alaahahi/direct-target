import 'package:flutter/material.dart';

import 'AllCardScreenBody.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/Routes.dart';

class AllCardScreen extends StatefulWidget {
  const AllCardScreen({super.key});

  @override
  State<AllCardScreen> createState() => _AllCardScreenState();
}

class _AllCardScreenState extends State<AllCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  size: MediaQuery.of(context).size.height * 0.025,
                ),
              ),
              onPressed: () => Get.offAllNamed(AppRoutes.homescreen)),
          title: Text(
            "My Card".tr,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 50,
        ),
        body: AllCardBodyScreen());
  }
}
