import 'package:flutter/cupertino.dart';
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

            return Column(
              children:[
                SizedBox(
                  height: Get.height * 0.05,
                ),
                ...cardController.allMyCardList!.map((service) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => CardServicesScreen(cardId: service.cardId!));
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: SizedBox(
                          width: double.infinity, // or a fixed width
                          height: 250, // specify a height
                          child: ShimmerImage(
                              imageUrl: service.image ?? 'Assets/images/4.jpg'),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ]
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