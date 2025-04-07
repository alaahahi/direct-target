import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Controller/AppointmentController.dart';
import '../../../../Controller/LoaderController.dart';
import '../../../../Utils/AppStyle.dart';
import '../../../../Widgets/CategoryList.dart';
import '../../../Routes/Routes.dart';
import '../../../Service/CardServices.dart';
import '../../Services/CategoryDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CardServicesTab extends StatefulWidget {

  final int cardId;
  const CardServicesTab({required this.cardId});
  @override
  State<CardServicesTab> createState() => _CardServicesTabState();
}
class _CardServicesTabState extends State<CardServicesTab> {
  LoaderController loaderController = Get.put(LoaderController());
  final CardController cardController = Get.put(CardController(CardServices()));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cardController.getCardServices(widget.cardId);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("✅ Card ID received: ${widget.cardId}");
    return Scaffold(

      body: GetBuilder<CardController>(

        builder: (cardController) {
          final selectedCard = cardController.allCardList?.firstWhereOrNull((card) => card.id == widget.cardId);

          if (selectedCard == null) {
            return Center(
              child: Text("No Card Found".tr, style: TextStyle(fontSize: 18, color: Colors.grey)),
            );
          }

          return CustomScrollView(
            slivers: [
              GetBuilder<CardController>(
                builder: (controller) {
                  if (loaderController.loading.value) {
                    return SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator(color: PrimaryColor)),
                    );
                  }
                  if (controller.categoryList == null || controller.categoryList!.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "No data available".tr,
                          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, categoryIndex) {
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
                        );
                      },
                      childCount: controller.categoryList!.length,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
class ShimmerImage extends StatelessWidget {
  final String imageUrl;

  ShimmerImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        child: Container(
          color: Colors.grey[300],
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red),
    );
  }
}

