import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Controller/AppointmentController.dart';
import '../../../../Controller/LoaderController.dart';
import '../../../../Utils/AppStyle.dart';
import '../../../../Widgets/CategoryList.dart';
import '../../../../Widgets/DoctorList.dart';

class CardServicesTab extends StatefulWidget {

  final int cardId;
  const CardServicesTab({required this.cardId});
  @override
  State<CardServicesTab> createState() => _CardServicesTabState();
}
class _CardServicesTabState extends State<CardServicesTab> {
  final AppointmentController appointmencontroller =
  Get.put(AppointmentController());
  LoaderController loaderController = Get.put(LoaderController());
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CardController>(
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
            Expanded(
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
                                  image: "Assets/images/person.jpg",
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
        );

      },
    );
  }
}

