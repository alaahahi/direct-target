import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AllSettingController.dart';
import '../../Service/SettingsServices.dart';
import '../../Utils/AppStyle.dart';

class OnBoard1 extends StatelessWidget {
  OnBoard1({super.key});
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

        Obx(() {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: _controller.firstImageUrl.value.isNotEmpty
                ? CachedNetworkImage(
              imageUrl: _controller.firstImageUrl.value,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error, color: Colors.red),
              ),
              fit: BoxFit.cover,
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 247, 247, 247),
                      const Color.fromARGB(255, 255, 255, 255),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Consult only with a doctor\nyou trust".tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: DarkBorderColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
