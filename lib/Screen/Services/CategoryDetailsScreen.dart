import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/AppointmentController.dart';
import '../../Controller/CardController.dart';
import '../../Controller/LoaderController.dart';
import '../../Service/CardServices.dart';
import '../../Widgets/DoctorList.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final int categoryId;

  CategoryDetailsScreen({required this.categoryId});

  final LoaderController loaderController = Get.put(LoaderController());
  final CardController cardController = Get.put(CardController(CardServices()));
  final AppointmentController appointmentController = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    final category = cardController.categoryList
        ?.firstWhereOrNull((cat) => cat.categoryId == categoryId);
    if (category == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Category Not Found".tr)),
        body: Center(
          child: Text(
            "No data available".tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(category.categoryName ?? "Category".tr)),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: category.subcategories?.map((subcategory) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      subcategory.subcategoryName ?? "No Subcategory",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subcategory.services?.length ?? 0,
                    itemBuilder: (context, serviceIndex) {
                      var service = subcategory.services![serviceIndex];

                      return GestureDetector(
                        onTap: () async {
                          await appointmentController.canBookAppointment(serviceId: service.id ?? 0);
                        },
                        child: doctorList(
                          maintext: service.serviceName ?? "No Name",
                          subtext: (service.specialty != null && service.specialty!.isNotEmpty)
                              ? "Specialization : ".tr + " " + service.specialty!
                              : "",
                          image: "Assets/images/person.jpg",
                          firstmaintext: service.reviewRate ?? "1",
                        ),
                      );
                    },
                  ),
                ],
              );
            }).toList() ?? [],
          ),
        ],
      ),
    );
  }
}

