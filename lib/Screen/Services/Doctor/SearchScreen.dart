import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import '../../../Controller/CardController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Service/CardServices.dart';
import '../../../Utils/AppStyle.dart';
import '../../../Widgets/DoctorList.dart';
import '../../RequestCard/RequestScreen.dart';


class doctor_search extends StatefulWidget {
  final int cardId;
  const doctor_search({required this.cardId});

  @override
  State<doctor_search> createState() => _doctor_searchState();
}

class _doctor_searchState extends State<doctor_search> {
  LoaderController loaderController = Get.put(LoaderController());
  final CardController cardController =
  Get.put(CardController(CardServices()));
  @override
  void initState() {
    super.initState();
    // cardController.getCards();
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

          return Column(
            children: [
              Container(
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
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Request Card".tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: LightGrey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Services".tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: GetBuilder<CardController>(
                  builder: (controller) {
                    if (controller.servicesList == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final allServices = controller.servicesList!
                        .expand((serviceGroup) => serviceGroup.services ?? [])
                        .toList();

                    final filteredServices = allServices
                        .where((service) => service.cardId == widget.cardId)
                        .toList();

                    return filteredServices.isEmpty
                        ? Center(
                      child: Text(
                        "No Services Available".tr,
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                        : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: filteredServices.length,
                      itemBuilder: (context, index) {
                        final service = filteredServices[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: DoctorDetails(doctorId: service.id!),
                              ),
                            );
                          },
                          child: doctorList(
                            maintext: service.serviceName ?? "No Name",
                            subtext: service.specialty ?? "No Description",
                            image:  "Assets/images/person.png",
                            firstmaintext :service.reviewRate ??  "1",
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

            ],
          );
        },
      ),


    );
  }
}
