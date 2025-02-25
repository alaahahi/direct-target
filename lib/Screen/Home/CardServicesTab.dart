import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AppointmentController.dart';

class CardServicesTab extends StatefulWidget {

  final int cardId;
  const CardServicesTab({required this.cardId});
  @override
  State<CardServicesTab> createState() => _CardServicesTabState();
}
class _CardServicesTabState extends State<CardServicesTab> {
  final AppointmentController appointmencontroller =
  Get.put(AppointmentController());
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:   Expanded(
          child: GetBuilder<CardController>(
            builder: (controller) {
              final filteredServices = controller.allServicesList!
                  .where((service) => service.cardId == widget.cardId)
                  .toList();
              return filteredServices.isEmpty
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "No Services Available".tr,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              )
                  : ListView.builder(
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return GestureDetector(
                    onTap: () async {
                      await appointmencontroller.canBookAppointment(serviceId: service.id ?? 0);
                    },

                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

