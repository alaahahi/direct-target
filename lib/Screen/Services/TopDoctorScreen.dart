import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AppointmentController.dart';
import '../../Controller/CardController.dart';
import '../../Controller/LoaderController.dart';
import '../../Service/CardServices.dart';
import '../../Widgets/DoctorList.dart';
import '../../Routes/Routes.dart';

class TopDoctorScreen extends StatelessWidget {
  TopDoctorScreen({super.key});
  final CardController cardController =
  Get.put(CardController(CardServices()));
  LoaderController loaderController = Get.put(LoaderController());
  final AppointmentController appointmencontroller =
  Get.put(AppointmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.homescreen);
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
                          onTap: () async {
                            await appointmencontroller.canBookPopularAppointment(serviceId: service.id ?? 0);
                          },
                          child:  doctorList(
                            image: service.image != null && service.image!.isNotEmpty
                                ? service.image!
                                : "Assets/images/person.jpg",
                            maintext: service.serviceName ?? "No Name",
                            subtext: (service.specialty != null && service.specialty!.isNotEmpty)
                                ? "Specialization : ".tr + " " + service.specialty!
                                : "",
                            firstmaintext :service.reviewRate ??  "1",
                          ),
                        ),
                      ],
                    ));
              });
        }));
  }
}
