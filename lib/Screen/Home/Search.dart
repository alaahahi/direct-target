import 'package:direct_target/Service/CardServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../Controller/CardController.dart';

import '../../Model/ServiceModel.dart';
import '../../Widgets/DoctorList.dart';
import '../Services/Doctor/DoctorDetailsScreen.dart';
class SearchPage extends StatelessWidget {
  final serviceController = Get.put(CardController(CardServices()));
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Services'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "ابحث عن خدمة...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    serviceController.searchServices(searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 16),

            Obx(() {
              if (serviceController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (serviceController.services.isEmpty) {
                return Center(child: Text('No services found.'));
              }

              return Expanded(
                  child:     ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: serviceController.services.length,
                    itemBuilder: (context, index) {
                      Service service = serviceController.services[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: DoctorDetails(doctorId: service.id!),
                            ),
                          );
                        },
                        child: doctorList(
                          maintext: service.serviceName ?? "No Name",
                          subtext: service.specialty ?? "No Description",
                          image:  "Assets/images/person.png",
                          firstmaintext :service.reviewRate ??  "1",
                        ),
                      );
                    },
                  )

              );
            }),
          ],
        ),
      ),
    );
  }
}