import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../../Controller/LoaderController.dart';
import 'Services Card/CardServicesScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
class AllCardBodyScreen extends StatefulWidget {
  const AllCardBodyScreen({super.key});

  @override
  State<AllCardBodyScreen> createState() => _AllCardBodyScreenState();
}

class _AllCardBodyScreenState extends State<AllCardBodyScreen> {
  LoaderController loaderController = Get.put(LoaderController());

  @override
  Widget build(BuildContext context) {
    return

      Container(
        width: 400,
        child: GetBuilder<CardController>(
          builder: (cardController) {
            if (loaderController.loading.value) {
              return Center(
                child: CircularProgressIndicator(color: PrimaryColor),
              );
            }

            if (cardController.allMyCardList == null) {
              return Center(
                child: Text(
                  "No data available".tr,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children:[
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  ...cardController.allMyCardList!.map((service) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => CardServicesScreen(cardId: service.cardId!));
                        },
              
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: (service.image != null &&
                                service.image!.isNotEmpty &&
                                service.image != "null")
                                ? Image.network(
                             service.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'Assets/images/4.jpg',
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                                : Image.asset(
                              'Assets/images/4.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
              
                      ),
                    );
                  }).toList(),

                ]
              ),
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