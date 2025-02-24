import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../Service/CardServices.dart';
import '../../Widgets/DoctorList.dart';
import '../Services/Doctor/DoctorDetailsScreen.dart';


class SearchPage extends StatelessWidget {
  final CardController serviceController = Get.put(CardController(CardServices()));
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("البحث عن الخدمات")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            Expanded(
              child: Obx(() {
                if (serviceController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }


                if (serviceController.servicesList == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final allServices = serviceController.servicesList!
                    .expand((serviceGroup) => serviceGroup.services ?? [])
                    .toList();
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: allServices.length,
                  itemBuilder: (context, index) {
                    final service = allServices[index];
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
