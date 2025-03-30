import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Controller/AppointmentController.dart';
import '../../../../Controller/LoaderController.dart';
import '../../../../Utils/AppStyle.dart';
import '../../../../Widgets/CategoryList.dart';
import '../../Services/CategoryDetailsScreen.dart';

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
                  if (controller.categoryList == null) {
                    return Center(
                      child: Text(
                        "Loading data...".tr,
                        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                      ),
                    );
                  }

                  if (controller.categoryList!.isEmpty) {
                    return Center(
                      child: Text(
                        "No data available".tr,
                        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.categoryList!.length,
                    itemBuilder: (context, categoryIndex) {
                      var category = controller.categoryList![categoryIndex];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CategoryDetailsScreen(categoryId: category.categoryId!));
                            },

                            child: CategoryList(
                              image: category.categoryIcon ?? "default",
                              maintext: category.categoryName ?? "No Name",
                              subtext: category.categoryDiscount ?? 0,
                            ),
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

