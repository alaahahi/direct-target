import 'package:direct_target/Controller/CardController.dart';
import 'package:flutter/material.dart';
import 'package:direct_target/Widgets/ScheduleCard.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../Widgets/DoctorList.dart';
import '../Services/Doctor/AppointmentScreen.dart';
import '../Services/Doctor/DoctorDetailsScreen.dart';

class CardServicesTab extends StatefulWidget {

  final int cardId;
  const CardServicesTab({required this.cardId});
  @override
  State<CardServicesTab> createState() => _CardServicesTabState();
}

class _CardServicesTabState extends State<CardServicesTab> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:     Expanded(
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
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: DoctorDetails(doctorId: service.id!),
                        ),
                      );
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

