import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../Controller/AppointmentController.dart';
import '../../Controller/CardController.dart';
import '../../Controller/LoaderController.dart';
import '../../Routes/Routes.dart';
import '../../Service/CardServices.dart';
import '../../Utils/AppStyle.dart';
import '../../Widgets/CategoryList.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../RequestCard/RequestSpecificCard.dart';
import 'CategoryDetailsScreen.dart';
class ServicesScreen extends StatefulWidget {
  final int cardId;
  const ServicesScreen({required this.cardId});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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

      body: NestedScrollView(

          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: false,
                pinned: true,
                expandedHeight: 100,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.homescreen);
                  },
                ),

                title: Text("Services of Card".tr, style: Theme.of(context).textTheme.headlineLarge),
                centerTitle: true,
              ),
            ];
          },

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
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 450,
                        child: Card(
                          margin: EdgeInsets.all(16.0),
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 250,
                                  child: ShimmerImage(
                                      imageUrl: selectedCard.image ?? 'Assets/images/4.jpg'),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedCard.name ?? "No Name",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold,
                                        color:  Colors.black,),
                                    ),
                                    SizedBox(height: 10),
                                    HtmlWidget(
                                      selectedCard.descriptionAr ?? "No description",
                                      textStyle: TextStyle(color: Colors.black87),
                                    ),

                                    SizedBox(height: 10),
                                    Text("Price: ".tr + "${selectedCard.price}  ${selectedCard.currency}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold,
                                      color:  Colors.black,),),
                                    SizedBox(height: 10),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: selectedCard.showOnApp == true
                            ? ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RequestSpecificCard(cardId: selectedCard.id!),)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PrimaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text(
                            "Request Card".tr,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: LightGrey),
                          ),
                        )
                            : SizedBox.shrink(),
                      ),

                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("All Services".tr, style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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