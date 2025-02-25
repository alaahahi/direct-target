import 'package:direct_target/Screen/Home/CardsScreenBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../Controller/LoaderController.dart';

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
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: CardScreenBody(cardId: service.id!),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'Assets/images/4.jpg',
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.cover,
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
