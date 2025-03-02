import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/CardController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Service/CardServices.dart';
import '../../Utils/AppStyle.dart';
import '../Schedule/ScheduleScreen.dart';
import 'CardServicesTab.dart';

class CardScreenBody extends StatefulWidget {
  final int cardId;
  const CardScreenBody({required this.cardId, Key? key}) : super(key: key);

  @override
  State<CardScreenBody> createState() => _CardScreenBodyState();
}

class _CardScreenBodyState extends State<CardScreenBody> with SingleTickerProviderStateMixin {
  LoaderController loaderController = Get.put(LoaderController());
  final CardController cardController = Get.put(CardController(CardServices()));

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              size: MediaQuery.of(context).size.height * 0.025,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Services of Card".tr,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: GetBuilder<CardController>(
        builder: (cardController) {
          final selectedCard = cardController.allCardList?.firstWhere(
                (card) => card.id == widget.cardId,
          );
          if (selectedCard == null) {
            return Center(
              child: Text(
                "No Card Found".tr,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    child: Card(
                      margin: EdgeInsets.all(16.0),
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              'Assets/images/4.jpg',
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedCard.name ?? "No Name",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Card Number: ${selectedCard.price}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Card Description: ${selectedCard.name ?? "No Description"}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: PrimaryColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      dividerColor: Colors.transparent,
                      indicatorColor: const Color.fromARGB(255, 241, 241, 241),
                      unselectedLabelColor: const Color.fromARGB(255, 32, 32, 32),
                      labelColor: Color.fromARGB(255, 255, 255, 255),
                      controller: tabController,
                      tabs: [
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
                ),
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: [
                CardServicesTab(cardId: selectedCard.id!),
                shedule_screen(),
              ],
            ),
          );
        },
      ),
    );
  }
}
