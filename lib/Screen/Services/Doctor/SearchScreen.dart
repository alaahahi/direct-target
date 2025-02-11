import 'package:flutter/material.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Screen/Services/Doctor/DoctorDetailsScreen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:get/get.dart';

import '../../../Controller/CardServiceController.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Utils/AppStyle.dart';
import '../../../Widgets/doctorList.dart';

class doctor_search extends StatefulWidget {
  const doctor_search({super.key});

  @override
  State<doctor_search> createState() => _doctor_searchState();
}

class _doctor_searchState extends State<doctor_search> {
  final CardServiceController controller = Get.put(CardServiceController());
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
                      type: PageTransitionType.fade, child: Homepage()));
            },
            child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/icons/back1.png"),
                  )),
            ),
          ),
          title: Text(
            "Top Doctors".tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 100,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("Assets/icons/more.png"),
                    )),
              ),
            ),
          ],
        ),
        body: GetBuilder<CardServiceController>(
            builder: (controller) => loaderController.loading.value
                ? Center(
              child: CircularProgressIndicator(color: PrimaryColor),
            )
                : controller.allServiceList!.isEmpty
                ? Center(
              child: Text(
                "No Services Available".tr, // رسالة عند عدم وجود خدمات
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: controller.allServiceList!.length,
              itemBuilder: (context, index) {
                final service = controller.allServiceList![index];
                return SafeArea(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: DoctorDetails(
                                    doctorId: service.id!)),
                          );
                        },
                        child: doctorList(
                          maintext: service.serviceName!.tr,
                          subtext: service.serviceName!.tr,
                          image: service.image != null
                              ? service.image!
                              : "Assets/icons/male-doctor.png",
                        ),
                      ),
                    ],
                  ),
                );
              },
            )));
  }
}
