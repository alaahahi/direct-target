import 'package:flutter/material.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import 'UpcomingScheduleScreen.dart';
import 'CompletedScheduleScreen.dart';
import 'CancelledScheduleScreen.dart';

class SheduleScreen extends StatefulWidget {
  const SheduleScreen({Key? key}) : super(key: key);

  @override
  _SheduleScreenState createState() => _SheduleScreenState();
}

class _SheduleScreenState extends State<SheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor:
                    PrimaryColor,
                    unselectedLabelColor:
                    const Color.fromARGB(255, 32, 32, 32),
                    labelColor:PrimaryColor,
                    controller: tabController,
                    tabs:  [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: Tab(
                          text: "Upcoming".tr,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: Tab(
                          text: "Completed".tr,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: Tab(
                          text: "Cancel".tr,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: TabBarView(
                controller: tabController,
                children:  [
                  UpcomingScheduleScreen(),
                  CompletedScheduleScreen(),
                  CancelledScheduleScreen(),
                ]))
      ],
    );
  }
}
