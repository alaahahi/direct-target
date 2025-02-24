import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Schedule/ScheduleScreenTab1.dart';
import 'package:direct_target/Screen/Schedule/ScheduleScreenTab2.dart';

import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';

import '../../Controller/CardController.dart';
import '../Schedule/ScheduleScreen.dart';
import 'CardServicesTab.dart';


class CardServicesScreen extends StatefulWidget {
  const CardServicesScreen({Key? key}) : super(key: key);

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<CardServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          padding: EdgeInsets.all(10),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color:PrimaryColor,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            dividerColor: Colors.transparent,
                            indicatorColor:
                            const Color.fromARGB(255, 241, 241, 241),
                            unselectedLabelColor:
                            const Color.fromARGB(255, 32, 32, 32),
                            labelColor: Color.fromARGB(255, 255, 255, 255),
                            controller: tabController,
                            tabs:  [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                                child: Tab(
                                  text: "Services".tr,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                                child: Tab(
                                  text: "Appointment".tr,
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
                    children: [
                      GetBuilder<CardController>(
                        builder: (cardController) {
                          if (cardController.allCardList == null || cardController.allCardList!.isEmpty) {
                            return Center(
                              child: Text(
                                "No data available".tr,
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            itemCount: cardController.allCardList!.length,
                            itemBuilder: (context, index) {
                              final service = cardController.allCardList![index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: CardServicesTab(cardId: service.id!),
                              );
                            },
                          );
                        },
                      ),


                      shedule_screen(),
                    ],
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
