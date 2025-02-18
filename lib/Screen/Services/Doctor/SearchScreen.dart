import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import '../../../Controller/CardController.dart';
import '../../../Controller/CardServiceController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Service/CardServices.dart';
import '../../../Utils/AppStyle.dart';
import '../../../Widgets/doctorList.dart';

class doctor_search extends StatefulWidget {
  final int cardId;
  const doctor_search({required this.cardId});

  @override
  State<doctor_search> createState() => _doctor_searchState();
}

class _doctor_searchState extends State<doctor_search> {
  final CardServiceController controller = Get.put(CardServiceController());
  LoaderController loaderController = Get.put(LoaderController());
  final CardController cardController =
  Get.put(CardController(CardServices()));
  @override
  void initState() {
    super.initState();
    cardController.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: Homepage(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              size: MediaQuery.of(context).size.height * 0.025,
            ),
          ),
        ),
        title: Text(
          "Services of Card".tr,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: GetBuilder<CardController>(
        builder: (controller) {
          if (loaderController.loading.value) {
            return Center(
              child: CircularProgressIndicator(color: PrimaryColor),
            );
          }

          final selectedCard = controller.allCardList?.firstWhere(
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
                height: 220,
                child: Card(
                  margin: EdgeInsets.all(16.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedCard.name ?? "Unknown Name",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Price: ${selectedCard.price} \$",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 10),
                        Text(
                          selectedCard.nameEn ?? "No Description Available",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                child:GetBuilder<CardServiceController>(
          builder: (controller) => controller.allServiceList!.isEmpty
          ? Center(
          child: Text(
          "No Services Available".tr,
          style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          )
              : ListView.builder(
                  itemCount: controller.allServiceList!.length,
                  itemBuilder: (context, index) {
                    final service = controller.allServiceList![index];
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
                      child:doctorList(
                        maintext: Get.locale?.languageCode == "ar"
                            ? service.serviceNameAr?.tr ?? "لا يوجد اسم"
                            : service.serviceNameEn?.tr ?? "No Name",
                        subtext: Get.locale?.languageCode == "ar"
                            ? service.descriptionAr?.tr ?? "لا يوجد وصف"
                            : service.descriptionEn?.tr ?? "No Description",

                        image: service.image != null && service.image!.isNotEmpty
                            ? service.image!
                            : "",
                      ),
                    );
                  },
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
