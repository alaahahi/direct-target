import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/AppointmentController.dart';
import '../../../Controller/CardController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Service/CardServices.dart';
import '../../../Utils/AppStyle.dart';
import '../../../Widgets/CategoryList.dart';
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
  final CardController cardController = Get.put(CardController(CardServices()));
  final AppointmentController appointmencontroller =
      Get.put(AppointmentController());
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
          return SingleChildScrollView(
            child: Column(
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
                          child: Image.network(
                            selectedCard.image ?? 'Assets/images/4.jpg',
                            width: MediaQuery.of(context).size.width,
                            height: 250,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Price: ${selectedCard.price}".tr,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 10),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: GetBuilder<CardController>(
                    builder: (controller) {
                      if (loaderController.loading.value) {
                        return Center(
                          child: CircularProgressIndicator(color: PrimaryColor),
                        );
                      }
                      if (controller.servicesList == null) {
                        return Center(
                          child: Text(
                            "Loading data...".tr,
                            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                          ),
                        );
                      }

                      if (controller.servicesList!.isEmpty) {
                        return Center(
                          child: Text(
                            "No data available".tr,
                            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.servicesList!.length,
                        itemBuilder: (context, categoryIndex) {
                          var category = controller.servicesList![categoryIndex];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CategoryList(
                                image: category.categoryIcon ?? "default",
                                maintext: category.categoryName ?? "No Name",
                                subtext: category.categoryDiscount ?? 0,
                              ),
                              SizedBox(height: 10),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: category.services?.length ?? 0,
                                itemBuilder: (context, serviceIndex) {
                                  var service = category.services![serviceIndex];

                                  return GestureDetector(
                                    onTap: () async {
                                      await appointmencontroller.canBookAppointment(serviceId: service.id ?? 0);
                                    },
                                    child: doctorList(
                                      maintext: service.serviceName ?? "No Name",
                                      subtext: service.specialty ?? "No Description",
                                      image: "Assets/images/person.png",
                                      firstmaintext: service.reviewRate ?? "1",
                                    ),
                                  );
                                },
                              ),
                              Divider(thickness: 1, color: Colors.grey[300]),
                            ],
                          ) ;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}
