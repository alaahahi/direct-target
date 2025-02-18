import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import '../../../Controller/CardController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Service/CardServices.dart';
import '../../../Widgets/doctorList.dart';

class TopDoctorScreen extends StatelessWidget {
  TopDoctorScreen({super.key});
  final CardController cardController =
  Get.put(CardController(CardServices()));
  LoaderController loaderController = Get.put(LoaderController());
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
            "Featured Services".tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 100,
        ),
        body: Obx(() {
          if (cardController.loaderController.loading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (cardController.allServicesList!.isEmpty) {
            return Center(
                child: Text("No services available"));
          }
          return ListView.builder(
              itemCount: cardController.allServicesList?.length,
              itemBuilder: (context, index) {
                final service = cardController.allServicesList![index];
                return SafeArea(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: DoctorDetails(doctorId: service.id!)));
                          },
                          child:  doctorList(
                            image: service.image != null && service.image!.isNotEmpty
                                ? service.image!
                                : "",
                            maintext: Get.locale?.languageCode == "ar"
                                ? service.serviceNameAr?.tr ?? "لا يوجد اسم"
                                : service.serviceNameEn?.tr ?? "No Name",
                            subtext: Get.locale?.languageCode == "ar"
                                ? service.descriptionAr?.tr ?? "لا يوجد وصف"
                                : service.descriptionEn?.tr ?? "No Description",
                          ),
                        ),
                      ],
                    ));
              });
        }));
  }
}
