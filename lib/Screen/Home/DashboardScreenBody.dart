import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Services/Doctor/SearchScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/FindDoctorScreen.dart';
import 'package:direct_target/Widgets/DoctorListHome.dart';
import 'package:direct_target/Widgets/IconsList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:get/get.dart';
import 'package:direct_target/Screen/RequestCard/RequestScreen.dart';

import '../../Controller/CardServiceController.dart';
import '../../Controller/LoaderController.dart';
import '../../Controller/TokenController.dart';
import '../../Service/CardServices.dart';


class DashboardScreenBody extends StatelessWidget {
  DashboardScreenBody({super.key});
  final tokenController = Get.put(TokenController());
  final CardServiceController controller = Get.put(CardServiceController());
  final CardController cardController =
  Get.put(CardController(CardServices()));
  LoaderController loaderController = Get.put(LoaderController());
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(),
            child: TextField(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: find_doctor()));
              },
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.none,
              autofocus: false,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusColor: Colors.black26,
                fillColor: Color.fromARGB(255, 247, 247, 247),
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child:Container(
                    child: Icon(
                      Icons.search,
                      size: MediaQuery.of(context).size.height * 0.025,
                      color: Colors.black,
                    ),
                  ),
                ),
                prefixIconColor:PrimaryColor,
                label: Text("Search doctor, drugs, articles...".tr),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            height: 250,
            width: 400,
            child:GetBuilder<CardController>(
              builder: (cardController) {
                if (loaderController.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(color: PrimaryColor),
                  );
                }

                if (cardController.allCardList!.isEmpty) {
                  return Center(
                    child: Text("No data available".tr,
                      style: TextStyle( color: Theme.of(context).textTheme.bodyMedium?.color,),),
                  );
                }

                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: cardController.allCardList!.map((service) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: doctor_search(cardId: service.id!),
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
                    );
                  }).toList(),
                );
              },
            )
        ),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => doctor_search()),
        //     );
        //   },
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(10.0),
        //     child: Image.asset(
        //       'Assets/images/4.jpg',
        //       width: MediaQuery.of(context).size.width,
        //       height: 250,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        // Container(
        //     child:GetBuilder<CardController>(
        //       builder: (controller) {
        //         if (loaderController.loading.value) {
        //           return Center(
        //             child: CircularProgressIndicator(color: PrimaryColor),
        //           );
        //         }
        //
        //         if (controller.allCardList!.isEmpty) {
        //           return Center(
        //             child: Text("No data available".tr,
        //               style: TextStyle( color: Theme.of(context).textTheme.bodyMedium?.color,),),
        //           );
        //         }
        //
        //         return ListView(
        //           physics: BouncingScrollPhysics(),
        //           scrollDirection: Axis.horizontal,
        //           children: controller.allCardList!.map((card) {
        //             return GestureDetector(
        //               onTap: () {
        //                 Navigator.push(
        //                   context,
        //                   PageTransition(
        //                     type: PageTransitionType.rightToLeft,
        //                     child: doctor_search(cardId: card.id!),
        //                   ),
        //                 );
        //               },
        //               child:ClipRRect(
        //                 borderRadius: BorderRadius.circular(10.0),
        //                 child: Image.asset(
        //                   card.name!,
        //                   width: MediaQuery.of(context).size.width,
        //                   height: 250,
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             );
        //           }).toList(),
        //         );
        //       },
        //     )
        // ),

        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListIcons(icon: Icons.medical_services_outlined, text: "Doctor".tr, color: PrimaryColor),
            ListIcons(icon: Icons.local_pharmacy, text: "Pharmacy".tr, color: PrimaryColor),
            ListIcons(icon: Icons.local_hospital, text: "Hospital".tr, color: PrimaryColor),
            ListIcons(icon: Icons.local_taxi, text: "Ambulance".tr, color: PrimaryColor),
          ],
        ),

        const SizedBox(
          height: 20,
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



        const SizedBox(
          height: 20,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Join Now".tr,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            GetBuilder<CardController>(
              builder: (controller) {
                // تأكد من أن القائمة ليست فارغة قبل تمرير cardId
                int? cardId = controller.allCardList!.isNotEmpty
                    ? controller.allCardList?.first.id // استخدم أول عنصر
                    : null; // إذا لم تكن هناك بيانات، اجعلها null

                return GestureDetector(
                  onTap: () {
                    if (cardId != null) {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: doctor_search(cardId: cardId),
                        ),
                      );
                    } else {
                      print("No card available to pass!");
                    }
                  },
                  child: Text(
                    "See all".tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 220,
          width: 400,
          child: GetBuilder<CardServiceController>(
            builder: (controller) {
              if (loaderController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(color: PrimaryColor),
                );
              }

              // التحقق من أن القائمة ليست null قبل محاولة استخدامها
              if (controller.allServiceList == null) {
                return Center(
                  child: Text(
                    "Loading data...".tr,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              // التأكد من أن القائمة ليست فارغة
              if (controller.allServiceList!.isEmpty) {
                return Center(
                  child: Text(
                    "No data available".tr,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                );
              }

              return ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: controller.allServiceList!.map((service) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: DoctorDetails(doctorId: service.id ?? 0), // تجنب القيم null
                        ),
                      );
                    },
                    child: list_doctor1(
                  image: service.image != null && service.image!.isNotEmpty
                  ? service.image! // استخدم الرابط القادم من الـ API
                    : "", // سنعالج الصورة الافتراضية في `list_doctor1`
                    maintext: Get.locale?.languageCode == "ar"
                        ? service.serviceNameAr?.tr ?? "لا يوجد اسم"
                        : service.serviceNameEn?.tr ?? "No Name",
                    subtext: Get.locale?.languageCode == "ar"
                        ? service.descriptionAr?.tr ?? "لا يوجد وصف"
                        : service.descriptionEn?.tr ?? "No Description",
                  ),

                  );
                }).toList(),
              );
            },
          ),
        )


      ]),
    );

  }
}
