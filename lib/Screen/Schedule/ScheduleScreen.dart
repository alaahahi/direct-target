import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Schedule/ScheduleScreenTab1.dart';
import 'package:direct_target/Screen/Schedule/ScheduleScreenTab2.dart';

import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';

import 'ScheduleScreenTab3.dart';

class shedule_screen extends StatefulWidget {
  const shedule_screen({Key? key}) : super(key: key);

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<shedule_screen>
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
    return  SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 00),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
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
                            SheduleTab1(),
                            SheduleTab2(),
                            SheduleTab3(),
                          ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
